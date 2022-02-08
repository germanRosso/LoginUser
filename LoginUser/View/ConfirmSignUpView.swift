//
//  ConfirmSignUp.swift
//  LoginUser
//
//  Created by German on 02/02/2022.
//

import SwiftUI

struct ConfirmSignUpView: View {
    
    @ObservedObject var userAuth: LoginViewModel
    @Binding var showSignUp: Bool
    @Binding var showLoginView: Bool
    @State var newPwAlert: NewPwAlert = .first
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                TitleConfirmSignUp(showSignUp: $showSignUp, showLoginView: $showLoginView)
                
                HeaderConfirmSignUp()
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    VStack {
                        ReusableTextField(titulo: "CONTRASEÑA ANTERIOR", textField: $userAuth.actualPassword, keyboardTipe: .default, isSecure: true)
                        ReusableTextField(titulo: "NUEVA CONTRASEÑA", textField: $userAuth.newPassword, keyboardTipe: .default, isSecure: true)
                        ReusableTextField(titulo: "REPETIR CONTRASEÑA", textField: $userAuth.confirmNewPw, keyboardTipe: .default, isSecure: true)
                    }
                    
                    Button(action: {
                        if newPwComplete {
                            userAuth.setNewPassword()
                        }
                        if userAuth.confirmNewPassword {
                            self.newPwAlert = .first
                        } else if userAuth.hasError {
                            self.newPwAlert = .second
                        } else {
                            self.newPwAlert = .third
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
            
            if userAuth.confirmNewPassword {
                LoggedInView()
            }
        }        
        .alert(isPresented: $showAlert) {
            switch newPwAlert {
            case .first:
                return Alert(title: Text(""), message: Text(userAuth.success), dismissButton: .default(Text("OK")))
            case .second:
                return Alert(title: Text(""), message: Text(userAuth.error), dismissButton: .default(Text("OK")))
            case .third:
                return Alert(title: Text(""), message: Text(userAuth.error), dismissButton: .default(Text("OK")))
            }
        }
    }
    func passwordsMatch() -> Bool {
        userAuth.newPassword == userAuth.confirmNewPw
    }
    var newPwComplete: Bool {
        if !passwordsMatch() {
            return false
        }
        return true
    }
}


enum NewPwAlert {
    case first, second, third
}


struct TitleConfirmSignUp: View {
    
    @Binding var showSignUp: Bool
    @Binding var showLoginView: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Text("CAMBIAR CONTRASEÑA")
                .font(.subheadline)
                .fontWeight(.regular)
            Spacer()
            Button {
                showSignUp.toggle()
//                showLoginView.toggle()
            } label: {
                Image("close_btn")
            }
        }
        .padding(.horizontal)
        Divider()
    }
}


struct HeaderConfirmSignUp: View {
    var body: some View {
        Text("Para poder ingresar a la app es necesario que cambie su contraseña")
            .font(.system(size: 14, weight: .light))
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
}

struct ConfirmSignUp_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmSignUpView(userAuth: LoginViewModel(), showSignUp: .constant(false), showLoginView: .constant(false))
    }
}
