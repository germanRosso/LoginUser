//
//  LoginModel.swift
//  LoginUser
//
//  Created by German on 27/01/2022.
//

import Foundation

struct AuthData: Codable {
    let usuario: [UserData]
    let codigo: Int
    let mensaje: String
    enum CodingKeys: String, CodingKey {
        case usuario = "Usuario"
        case codigo = "Codigo"
        case mensaje = "Mensaje"
    }
}

struct UserData: Codable, Identifiable {
    let id: Int
    let idClearSky: Int
    let nombre: String
    let apellido: String
    let celular: String
    let usuario: String
    let cambiarContrasena: Bool
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case idClearSky = "IdClearSky"
        case nombre = "Nombre"
        case apellido = "Apellido"
        case celular = "Celular"
        case usuario = "Usuario"
        case cambiarContrasena = "CambiarContrasena"
    }
}
