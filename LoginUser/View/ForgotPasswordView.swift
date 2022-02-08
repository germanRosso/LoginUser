//
//  SwiftUIView.swift
//  LoginUser
//
//  Created by German on 01/02/2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @ObservedObject var userAuth: LoginViewModel
    @Binding var showForgotPassword: Bool
    @Binding var showLoginView: Bool
    @State var forgotPwAlert: ForgotPwAlert = .first
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                TitleForgotPassword(showForgotPassword: $showForgotPassword, showLoginView: $showLoginView)
                
                HeaderForgotPassword()
                
                Spacer()
                
                VStack {
                    Spacer()
                    VStack {
                        ReusableTextField(titulo: "EMAIL", textField: $userAuth.email, keyboardTipe: .emailAddress, isSecure: false)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        userAuth.sendNewPassword()
                        if userAuth.resetPassword {
                            self.forgotPwAlert = .first
                            print(userAuth.success)
                        } else if userAuth.hasError {
                            self.forgotPwAlert = .second
                            print(userAuth.error)
                        } else {
                            self.forgotPwAlert = .third
                            print(userAuth.error)
                        }
                        self.showAlert = true
                    }) {
                        Text("Siguiente")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding()
                            .padding(.horizontal, 60)
                            .foregroundColor(.white)
                            .background(.black)
                            .clipShape(Capsule())
                    }
                    .padding(.bottom)
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 50, height: 480, alignment: .center)
            .background(Color.white)
            .border(Color.gray.opacity(0.3))
        }
        .alert(isPresented: $showAlert) {
            switch forgotPwAlert {
            case .first:
                return Alert(title: Text(""), message: Text(userAuth.success), dismissButton: .default(Text("OK")))
            case .second:
                return Alert(title: Text(""), message: Text(userAuth.error), dismissButton: .default(Text("OK")))
            case .third:
                return Alert(title: Text(""), message: Text(userAuth.error), dismissButton: .default(Text("OK")))
            }
        }
    }
}
enum ForgotPwAlert {
    case first, second, third
}


struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(userAuth: LoginViewModel(), showForgotPassword: .constant(false), showLoginView: .constant(false))
    }
}

struct TitleForgotPassword: View {
    
    @Binding var showForgotPassword: Bool
    @Binding var showLoginView: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Text("RECUPERAR CONTRASEÑA")
                .font(.subheadline)
                .fontWeight(.regular)
            Spacer()
            Button {
                showForgotPassword.toggle()
                showLoginView.toggle()
            } label: {
                Image("close_btn")
            }
        }
        .padding(.horizontal)
        Divider()
    }
}


struct HeaderForgotPassword: View {
    var body: some View {
        Text("Ingrese su email y recibirá un correo electrónico con instrucciones.")
            .font(.system(size: 14, weight: .light))
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
}
