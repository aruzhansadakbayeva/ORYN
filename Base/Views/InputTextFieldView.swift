//
//  InputTextFieldView.swift
//  BCR
//
//  Created by Aruzhan  on 14.12.2022.
//

import SwiftUI

struct InputTextFieldView: View {
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    var body: some View {
        TextField(placeholder, text: $text).frame(maxWidth: .infinity, minHeight: 44).padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading).keyboardType(keyboardType).foregroundColor(Color.white).background(
            ZStack(alignment: .leading){
                if let systemImage = sfSymbol {
                    Image(systemName: systemImage).font(.system(size: 16, weight: .semibold)).padding(.leading, 5).foregroundColor(Color.white)
                }
                
                RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.white)
            })
    }
}

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputTextFieldView(text: .constant(""),
                               placeholder: "Email",
                               keyboardType:.emailAddress,
                               sfSymbol: "envelope").preview(with: "Email Text Input with sfsymbol")
            
            InputTextFieldView(text: .constant(""),
                               placeholder: "First Name",
                               keyboardType:.default,
                               sfSymbol: "nil").preview(with: "First Name Text Input with sfsymbol")
            
        }
    }
}
