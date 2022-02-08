//
//  LoginView.swift
//  LoginUser
//
//  Created by German on 27/01/2022.
//

import SwiftUI
import SwiftUIX

struct LoginView: View {
    
    @ObservedObject var userAuth: LoginViewModel
    @Binding var showLoginView: Bool
    @State private var checked = false
    @Binding var showForgotPassword: Bool
    @Binding var showSignUp: Bool
    @State var alertLogin: AlertLogin?
    
    var body: some View {
        ZStack {
            VStack {
                TitleLogin(showLoginView: $showLoginView)
                
                Spacer()
                
                VStack {
                    HeaderLogin()
                    
                    VStack {
                        ReusableTextField(titulo: "EMAIL", textField: $userAuth.email, keyboardTipe: .emailAddress, isSecure: false)
                        
                        ReusableTextField(titulo: "CONTRASEÑA", textField: $userAuth.actualPassword, keyboardTipe: .default, isSecure: true)
                        
                        Button {
                            withAnimation {
                                showForgotPassword.toggle()
                                showLoginView.toggle()
                            }
                        } label: {
                            Text("Olvidé mi contraseña")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Toggle(isOn: $checked) {
                            HStack(spacing: 5) {
                                Text("Acepto los")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                Link("términos y condiciones", destination: URL(string: "https://www.theappmaster.com/")!)
                                    .foregroundColor(Color.black)
                                    .font(.footnote, weight: .bold)
                            }
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        .padding(.top)
                    }
                    .padding()
                    
                    Button(action: {
                        if checked {
                            userAuth.signIn()
                        } else {
                            alertLogin = .tyc
                        }
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
                    
                    
                    CreateAccount(showSignUp: $showSignUp, showLoginView: $showLoginView)
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 50, height: 480, alignment: .center)
            .background(Color.white)
            .border(Color.gray.opacity(0.3))
            
            if userAuth.isSignedIn && !userAuth.cambiarContrasena {
                LoggedInView()
            } else if userAuth.isSignedIn && userAuth.cambiarContrasena {
                ConfirmSignUpView(userAuth: LoginViewModel(), showSignUp: $showSignUp, showLoginView: $showLoginView)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(.ultraThinMaterial)
        
        .alert(item: $alertLogin) { type in
            switch type {
            case .tyc:
                return Alert(title: Text(""), message: Text("Debe aceptar los términos y condiciones"), dismissButton: .default(Text("OK")))
            case .errorLogin:
                return Alert(title: Text(""), message: Text(userAuth.error), dismissButton: .default(Text("OK")))
            }
        }
//        .alert(isPresented: $userAuth.hasError) {
//            Alert(title: Text(""), message: Text(userAuth.error), dismissButton: .default(Text("OK")))
//        }
    }
}

enum AlertLogin: Identifiable {
    case tyc, errorLogin
    var id: Int {
        hashValue
    }
}

//    .alert(isPresented: $alertTyC) {
//        Alert(title: Text(""), message: Text("Debe aceptar los términos y condiciones"), dismissButton: .default(Text("OK")))
//        }


struct TitleLogin: View {
    
    @Binding var showLoginView: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Text("INGRESA A TU CUENTA")
                .font(.subheadline)
                .fontWeight(.regular)
            Spacer()
            Button { showLoginView.toggle()
            } label: {
                Image("close_btn")
            }
        }
        .padding(.horizontal)
        Divider()
    }
}


struct HeaderLogin: View {
    var body: some View {
        Text("Con tu acceso vas a poder acceder a tus turnos, confirmarlos o reprogramarlos. Y acceder a las mejores ofertas y novedades.")
            .font(.system(size: 14, weight: .light))
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
}


struct CreateAccount: View {
    
    @Binding var showSignUp: Bool
    @Binding var showLoginView: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            Text("No tienes una cuenta?")
                .font(.footnote)
                .fontWeight(.regular)
            Button {
                withAnimation {
                    showSignUp.toggle()
                    showLoginView.toggle()
                }
            } label: {
                Text("Click aquí")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userAuth: LoginViewModel(), showLoginView: .constant(false), showForgotPassword: .constant(false), showSignUp: .constant(false))
    }
}
