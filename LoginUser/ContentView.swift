//
//  ContentView.swift
//  LoginUser
//
//  Created by German on 27/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var showLoginView: Bool
    @State var showForgotPassword: Bool
    @State var showSignUp: Bool
    @State var email : String = ""
    @State var contrasena : String = ""

    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Debes ingresar a tu cuenta para ver tus datos personales")
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .padding()
                Button(action: {
                    withAnimation {
                        showLoginView.toggle()
                    }
                }) {
                    Text("Ingresar")
                        .font(.headline)
                        .fontWeight(.regular)
                        .padding()
                        .padding(.horizontal, 60)
                        .foregroundColor(.white)
                        .background(.black)
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            if showLoginView {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.black, .white]),
                            startPoint: .top,
                            endPoint: .center))
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .offset(y: -300)
                    LoginView(userAuth: LoginViewModel(), showLoginView: $showLoginView, showForgotPassword: $showForgotPassword, showSignUp: $showSignUp)
                }
            }
            if showForgotPassword {
                ForgotPasswordView(userAuth: LoginViewModel(), showForgotPassword: $showForgotPassword, showLoginView: $showLoginView)
            }
            if showSignUp {
                SignUpView(userAuth: LoginViewModel(), showSignUp: $showSignUp, showLoginView: $showLoginView)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(showLoginView: Bool(false), showForgotPassword: Bool(false), showSignUp: Bool(false), mensajeAlerta: )
//    }
//}
