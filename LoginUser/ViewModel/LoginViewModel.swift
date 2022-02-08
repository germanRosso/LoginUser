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
    
    @Published var authData = [AuthData]()
    @Published var userData = [UserData]()
    @Published var email : String = "german.rosso@theappmaster.com"
    @Published var actualPassword : String = "german"
    @Published var nombre: String = ""
    @Published var apellido: String = ""
    @Published var mail: String = ""
    @Published var telefono: String = ""
    @Published var newPassword: String = ""
    @Published var confirmNewPw: String = ""
    @Published var hasError = false
    @Published var isSignedIn = false
    @Published var resetPassword = false
    @Published var newUser = false
    @Published var confirmNewPassword = false
    @Published var cambiarContrasena = false
    @Published var error: String = ""
    @Published var success: String = ""
    
    
    //MARK: - Iniciar Sesion
    
    func signIn() {
        
        guard let url = URL(string: "http://dermaservice.theappmaster.com/Login.ashx") else {
            return
        }
        
        let parameters: [String : Any] = ["Usuario" : email, "Contrasena" : actualPassword]
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json", "User":"Dermacycle2018", "Password":"7c4e22f4-6a6c-48de-b1c9-075979233ce5", "Dispositivo":"iPhone 7", "VersionSO":"iOS 11.2.2", "VersionAPP":"1.0.1"
        ]
        
        AF.request("\(url)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseData { (data) in
            
            let json = try! JSON(data: data.data!)
            let codigo = json["Codigo"].intValue
            let mensaje = json["Mensaje"].stringValue
            let contrasenaAutomatica = json["Usuario"][0]["CambiarContrasena"].boolValue
            self.cambiarContrasena = contrasenaAutomatica
            print(contrasenaAutomatica)
            print(codigo)
            print(mensaje)
            
            if codigo == 0 {
                self.isSignedIn.toggle()
            } else {
                self.hasError.toggle()
                self.error = mensaje
            }
        }
    }

    
    //MARK: - Olvidé mi Contraseña
    
    func sendNewPassword() {
        
        guard let url = URL(string: "http://dermaservice.theappmaster.com/Contrasena.ashx") else {
            return
        }
        
        let parameters: [String : Any] = ["Usuario" : email]
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json", "User":"Dermacycle2018", "Password":"7c4e22f4-6a6c-48de-b1c9-075979233ce5", "Dispositivo":"iPhone 7", "VersionSO":"iOS 11.2.2", "VersionAPP":"1.0.1"
        ]
        
        AF.request("\(url)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseData { (data) in
            
            let json = try! JSON(data: data.data!)
            let codigo = json["Codigo"].intValue
            let mensaje = json["Mensaje"].stringValue
            
            if codigo == 0 {
                self.resetPassword.toggle()
                self.success = mensaje
                print(json)
            } else if codigo == 202 {
                self.hasError.toggle()
                self.error = mensaje
                print(json)
            }  else {
                self.hasError.toggle()
                self.error = mensaje
                print(json)
            }
        }
    }
    
    
    //MARK: - Solicitud de Nuevo Usuario
    
    func signUp() {
        
        guard let url = URL(string: "http://dermaservice.theappmaster.com/Solicitud.ashx") else {
            return
        }
        
        let parameters: [String : Any] = ["Nombre" : nombre, "Apellido" : apellido, "Mail" : mail, "Telefono" : telefono]
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json", "User":"Dermacycle2018", "Password":"7c4e22f4-6a6c-48de-b1c9-075979233ce5", "Dispositivo":"iPhone 7", "VersionSO":"iOS 11.2.2", "VersionAPP":"1.0.1"
        ]
        
        AF.request("\(url)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseData { (data) in
            
            let json = try! JSON(data: data.data!)
            let codigo = json["Codigo"].intValue
            let mensaje = json["Mensaje"].stringValue
            
            if codigo == 91 {
                self.newUser.toggle()
                self.success = mensaje
                print(json)
            } else {
                self.hasError.toggle()
                self.error = mensaje
                print(json)
            }
        }
    }
    
    
    //MARK: - Confirmar contraseña nuevo usuario
    
    func setNewPassword() {
        
        guard let url = URL(string: "http://dermaservice.theappmaster.com/Contrasena.ashx") else {
            return
        }
        
        let parameters: [String : Any] = ["Usuario" : email, "Contrasena" : actualPassword, "NuevaContrasena" : newPassword]
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json", "User":"Dermacycle2018", "Password":"7c4e22f4-6a6c-48de-b1c9-075979233ce5", "Dispositivo":"iPhone 7", "VersionSO":"iOS 11.2.2", "VersionAPP":"1.0.1"
        ]
        
        AF.request("\(url)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseData { (data) in
            
            let json = try! JSON(data: data.data!)
            let codigo = json["Codigo"].intValue
            let mensaje = json["Mensaje"].stringValue
            
            if codigo == 0 {
                self.confirmNewPassword.toggle()
            } else if codigo == 202 {
                self.hasError.toggle()
                self.error = mensaje
                print(json)
            }  else {
                self.hasError.toggle()
                self.error = mensaje
                print(json)
            }
        }
    }
}
