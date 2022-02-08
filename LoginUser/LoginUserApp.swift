//
//  LoginUserApp.swift
//  LoginUser
//
//  Created by German on 27/01/2022.
//

import SwiftUI

@main
struct LoginUserApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(showLoginView: Bool(false), showForgotPassword: Bool(false), showSignUp: Bool(false))
        }
    }
}
