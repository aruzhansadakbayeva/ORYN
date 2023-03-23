//
//  LoginView.swift
//  BCR
//
//  Created by Aruzhan  on 14.12.2022.
//
import SwiftUI

struct LoginView: View {
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    @StateObject private var vm = LoginViewModelImpl(service: LoginServiceImpl())
    var backgroundColors: [Color] = [Color("backgroundColor"),Color("purple")]

    var body: some View {
   

        ZStack {
            LinearGradient(gradient: Gradient(colors: backgroundColors),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                VStack(spacing: 16){
                    InputTextFieldView(text: $vm.credentials.email,
                                       placeholder: "Email",
                                       keyboardType: .emailAddress,
                                       sfSymbol: "envelope")
                

                    InputPasswordView(password: $vm.credentials.password,
                                      placeholder: "Password",
                                      sfSymbol: "lock")
                     //   .font(.system(size: 16, weight: .bold))
                      

               
                }
                HStack {
                    Spacer()
                    Button(action: {
                        showForgotPassword.toggle()
                    }, label: {
                        Text("Забыли пароль?")
                    }).font(.system(size: 16, weight: .bold)).foregroundColor(Color("pink"))
                        .sheet(isPresented: $showForgotPassword, content: {
                            ForgotPasswordView()
                        })
                }
                
                VStack(spacing: 16) {
                    ButtonView(title: "Войти", background: Color("pink")){ vm.login()
                    }
                    ButtonView(title: "Зарегистрироваться", background: .clear,
                               foreground: Color("pink"),
                               border: Color("pink")){
                        showRegistration.toggle()
                    }
                               .sheet(isPresented: $showRegistration, content: {
                                   RegisterView()
                               })
                }
            } .padding(.horizontal, 15)
                .navigationTitle("Вход")
            
                .alert(isPresented: $vm.hasError, content: {
                    if case .failed(let error) = vm.state {
                        return Alert(title: Text("Error"),
                                     message: Text(error.localizedDescription))
                    } else {
                        return Alert(title: Text("Error"),
                                     message: Text("Something went wrong"))
                    }
                })
            
        }
    }

}
