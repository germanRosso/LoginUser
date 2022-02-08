//
//  ReusableTextField.swift
//  LoginUser
//
//  Created by German on 08/02/2022.
//

import SwiftUI

struct ReusableTextField: View {
    
    var titulo: String
    var textField: Binding<String>
    var keyboardTipe: UIKeyboardType
    var isSecure: Bool
    
    var body: some View {
        VStack {
            Text(titulo)
                .font(.subheadline)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            if isSecure {
                SecureField("", text: textField)
                .modifier(CustomTFModifier(keyboard: keyboardTipe))
            } else {
                TextField("", text: textField)
                    .modifier(CustomTFModifier(keyboard: keyboardTipe))
            }
        }
        .padding(.bottom)
    }
}


struct CustomTFModifier: ViewModifier {
    
    var keyboard: UIKeyboardType
    
    func body(content: Content) -> some View {
        content
            .overlay(Rectangle().frame(height: 1).offset(y: 15))
            .foregroundColor(Color.black)
            .autocapitalization(.none)
            .keyboardType(keyboard)
            .disableAutocorrection(true)
            .hideKeyboardWhenTappedAround()
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


struct ReusableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ReusableTextField(titulo: "", textField: .constant(""), keyboardTipe: UIKeyboardType.default, isSecure: false)
    }
}
