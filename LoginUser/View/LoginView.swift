//
//  LoginView.swift
//  LoginUser
//
//  Created by German on 27/01/2022.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var showLoginView: Bool
    @ObservedObject var userAuth: LoginViewModel
    @State private var checked = false
//    @State var email: String = ""
//    @State var contrasena: String = ""

    var body: some View {
        ZStack {
            VStack {
                TitleLogin(showLoginView: $showLoginView)
                
                Spacer()
                
                VStack {
                    HeaderLogin()
                    
//                    UserSection()
                    VStack {
                        Text("EMAIL")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        VStack {
                            TextField("", text: $userAuth.email)
                                .keyboardType(UIKeyboardType.emailAddress)
                                .hideKeyboardWhenTappedAround()
                                .autocapitalization(.none)
                            Rectangle()
                                .frame(height: 1)
                                .background(Color.gray.opacity(0.5))
                            //                    .padding(.top)
                        }
                        
                        Text("CONTRASEÑA")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                        
                        VStack {
                            TextField("", text: $userAuth.contrasena)
                                .keyboardType(UIKeyboardType.default)
                                .hideKeyboardWhenTappedAround()
                                .autocapitalization(.none)
                            Rectangle()
                                .frame(height: 1)
                                .background(Color.gray.opacity(0.5))
                            //                    .padding(.top)
                        }
                        
                        
                        Button {} label: {
                            Text("Olvidé mi contraseña")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Toggle(isOn: $checked) {
                            Text("Acepto los")
                                .font(.footnote)
                                .fontWeight(.regular)
                            Button {} label: {
                                Text("términos y condiciones")
                                    .underline()
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                            }
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        
                        .padding(.top)
                    }
                    .padding()
                    
                    Button(action: {
                        userAuth.signIn()
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
//                    SiguienteButton()
//                        .padding(.bottom)
                    
                    
                    CreateAccount()
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 50, height: 480, alignment: .center)
            .background(Color.white)
            .border(Color.gray.opacity(0.3))
            
            if userAuth.isSignedIn {
                LoggedInView()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(.ultraThinMaterial)
    }
}


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
    var body: some View {
        HStack(spacing: 5) {
            Text("No tienes una cuenta?")
                .font(.footnote)
                .fontWeight(.regular)
            Button {} label: {
                Text("Click aquí")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            }
        }
    }
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            //            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


extension View {
    func hideKeyboardWhenTappedAround() -> some View  {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(showLoginView: $showLoginView, userAuth: LoginViewModel)
//    }
//}
