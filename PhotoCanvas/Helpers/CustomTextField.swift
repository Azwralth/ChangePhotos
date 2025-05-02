//
//  CustomTextField.swift
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    var iconName: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.primary)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.purple.opacity(0.8), lineWidth: 1)
        )
    }
}
