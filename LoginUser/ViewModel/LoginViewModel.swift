//
//  LoginViewModel.swift
//  LoginUser
//
//  Created by German on 27/01/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class LoginViewModel: ObservableObject {
    
    @Published var email : String = "cobelon@gmail.com"
    @Published var contrasena : String = "1234"
//    @Published var hasError = false
    @Published var isSignedIn = false
    @Published var jsonUsers = [DataUser]()

//
//    init(email: String, contrasena: String) {
//        self.email = email
//        self.contrasena = contrasena
//        signIn()
//    }
    
    func signIn() {
        
        guard let url = URL(string: "http://dermaservice.theappmaster.com/Login.ashx") else {
            return
        }
        
        let parameters: [String : Any] = ["Usuario" : email, "Contrasena" : contrasena]

        let headers: HTTPHeaders = [
            "Content-Type":"application/json", "User":"Dermacycle2018", "Password":"7c4e22f4-6a6c-48de-b1c9-075979233ce5", "Dispositivo":"iPhone 7", "VersionSO":"iOS 11.2.2", "VersionAPP":"1.0.1"
        ]
//        
//        AF.request("\(url)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { response in
//            print(response)
//        }
        AF.request("\(url)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { (data) in

            
            let json = try! JSON(data: data.data!)
            let userValidation = json["Codigo"]
            
//            print(userValidation)
//
            if userValidation == 0 {
                self.isSignedIn.toggle()
            } else {
                print("Error")
            }
        }
    }
}



//    if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
//        self.hasError = true
//    } else if let data = data {
//        do {
//            let signInResponse = try JSONDecoder().decode(DataUser.self, from: data)
//
//            print(signInResponse)
//
//        } catch {
//            print("Unable to Decode Response \(error)")
//        }
//    }
//    self.isSignedIn.toggle()




//@Published var jsonUsers = [DataUser]()
//
//
//        guard let url = URL(string: "http://dermaservice.theappmaster.com/Login.ashx") else {
//            return
//        }
//
//        let headers: HTTPHeaders = [
//            "Content-Type":"application/json", "User":"Dermacycle2018", "Password":"7c4e22f4-6a6c-48de-b1c9-075979233ce5", "Dispositivo":"iPhone 7", "VersionSO":"iOS 11.2.2", "VersionAPP":"1.0.1"
//        ]
//
//        AF.request("\(url)", method: .post, headers: headers).responseData { (data) in
//
//            let json = try! JSON(data: data.data!)
//            let user = json[DataUser].array!
//
//            for i in user {
//                let email = i["Usuario"].stringValue
//                let contrasena = i[
//            }
//
//            DispatchQueue.main.async {
//                self.jsonUsers.append(
//            }
//        }
//    }
