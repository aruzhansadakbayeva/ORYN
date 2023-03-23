//
//  RegisterView.swift
//  BCR
//
//  Created by Aruzhan  on 15.12.2022.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var vm = RegistrationViewModelImpl( service: RegistrationServiceImpl() )
    var backgroundColors: [Color] = [Color("backgroundColor"),Color("purple")]
    var body: some View {
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: backgroundColors),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 32) {
                    VStack(spacing: 16){
                        InputTextFieldView(text: $vm.userDetails.email,
                                           placeholder: "Email",
                                           keyboardType:.emailAddress,
                                           sfSymbol: "envelope")
                        InputPasswordView(password: $vm.userDetails.password,
                                          placeholder: "Password",
                                          sfSymbol: "lock")
                        
                        Divider()
                        
                        InputTextFieldView(text: $vm.userDetails.firstName,
                                           placeholder: "First Name",
                                           keyboardType:.namePhonePad,
                                           sfSymbol: "envelope")
                        InputTextFieldView(text: $vm.userDetails.lastName,
                                           placeholder: "Last Name",
                                           keyboardType:.namePhonePad,
                                           sfSymbol: "envelope")
                        
                    }
                    ButtonView(title: "Зарегистрироваться", background: Color("pink")) {
                        vm.register()
                    }
                    
                }.padding(.horizontal, 15)
                    .navigationTitle("Регистрация").applyClose()            .alert(isPresented: $vm.hasError, content: {
                        if case .failed(let error) = vm.state {
                            return Alert(title: Text("Error"),
                                         message: Text(error.localizedDescription))
                        } else {
                            return Alert(title: Text("Error"),
                                         message: Text("Something went wrong"))
                        }
                    })
            }   .background(LinearGradient(colors: backgroundColors, startPoint: .leading, endPoint: .trailing))
        }
    }
    
    
    
}
