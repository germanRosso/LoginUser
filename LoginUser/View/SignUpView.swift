//
//  SignUpView.swift
//  LoginUser
//
//  Created by German on 01/02/2022.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var userAuth: LoginViewModel
    @Binding var showSignUp: Bool
    @Binding var showLoginView: Bool
    @State private var checked = false
    @State private var newUserAlert: NewUserAlert = .first
    @State private var showAlert = false

    var body: some View {
        ZStack {
            VStack {
                TitleSignUp(showSignUp: $showSignUp, showLoginView: $showLoginView)
                
                HeaderSignUp()
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    VStack {
                        HStack {
                            ReusableTextField(titulo: "NOMBRE", textField: $userAuth.nombre, keyboardTipe: .default, isSecure: false)
                            ReusableTextField(titulo: "APELLIDO", textField: $userAuth.apellido, keyboardTipe: .default, isSecure: false)
                        }
                        ReusableTextField(titulo: "EMAIL", textField: $userAuth.mail, keyboardTipe: .emailAddress, isSecure: false)
                        ReusableTextField(titulo: "TELEFONO", textField: $userAuth.telefono, keyboardTipe: .default, isSecure: false)
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
                    .padding()
                    
                    Button(action: {
                        userAuth.signUp()
                        if userAuth.newUser {
                            self.newUserAlert = .first
                        } else if userAuth.hasError {
                            self.newUserAlert = .second
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
            
            if userAuth.newUser {
                LoggedInView()
            }
        }
        .alert(isPresented: $showAlert) {
            switch newUserAlert {
            case .first:
                return Alert(title: Text(""), message: Text(userAuth.success), dismissButton: .default(Text("OK")))
            case .second:
                return Alert(title: Text(""), message: Text(userAuth.error), dismissButton: .default(Text("OK")))
            }
        }
    }
}


enum NewUserAlert {
    case first, second
}


struct TitleSignUp: View {
    
    @Binding var showSignUp: Bool
    @Binding var showLoginView: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Text("SOLICITAR ACCESO")
                .font(.subheadline)
                .fontWeight(.regular)
            Spacer()
            Button {
                showSignUp.toggle()
                showLoginView.toggle()
            } label: {
                Image("close_btn")
            }
        }
        .padding(.horizontal)
        Divider()
    }
}


struct HeaderSignUp: View {
    var body: some View {
        Text("Complete el siguiente formulario para solicitar acceso a la aplicación")
            .font(.system(size: 14, weight: .light))
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(userAuth: LoginViewModel(), showSignUp: .constant(false), showLoginView: .constant(false))
    }
}
