//
//  LoginViewModel.swift
//  LoginUser
//
//  Created by German on 27/01/2022.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    @Published var email : String = ""
    @Published var contrasena : String = ""
    @Published var hasError = false
    @Published var isSigningIn = false
    
    var canSignIn: Bool {
        !email.isEmpty && !contrasena.isEmpty
    }
    
    func signIn(email: String, contrasena: String) {
        guard !email.isEmpty && !contrasena.isEmpty else {
            return
        }
        var request = URLRequest(url: URL(string: "http://dermaservice.theappmaster.com/Login.ashx")!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Dermacycle2018", forHTTPHeaderField: "User")
        request.addValue("7c4e22f4-6a6c-48de-b1c9-075979233ce5", forHTTPHeaderField: "Password")
        request.addValue("iPhone 7", forHTTPHeaderField: "Dispositivo")
        request.addValue("iOS 11.2.2", forHTTPHeaderField: "VersionSO")
        request.addValue("1.0.1", forHTTPHeaderField: "VersionAPP")
        
        isSigningIn.toggle()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    self.hasError = true
                } else if let data = data {
                    do {
                        let signInResponse = try JSONDecoder().decode(DataUser.self, from: data)
                        
                        print(signInResponse)
                        
                    } catch {
                        print("Unable to Decode Response \(error)")
                    }
                }
                self.isSigningIn.toggle()
            }
        }.resume()
    }
}
