//
//  CheckboxToggleStyle.swift
//  LoginUser
//
//  Created by German on 08/02/2022.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            //            Spacer()
            Image(configuration.isOn ? "check-square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
