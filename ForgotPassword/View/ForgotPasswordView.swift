//
//  ForgotPasswordView.swift
//  BCR
//
//  Created by Aruzhan  on 15.12.2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm = ForgotPasswordViewModelImpl( service: ForgotPasswordServiceImpl())
    var body: some View {
        NavigationView{
            VStack(spacing: 16){
                InputTextFieldView(text: $vm.email,
                                   placeholder: "Email",
                                   keyboardType: .emailAddress,
                                   sfSymbol: "envelope")
                ButtonView(title: "Отправить сброс пароля", background: Color("pink")){
                    vm.sendPasswordReset()
                    presentationMode.wrappedValue.dismiss()
                }
                
            }.padding(.horizontal, 15)
                .navigationTitle("Сбросить пароль").applyClose()
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
