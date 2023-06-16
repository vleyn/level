//
//  SignUpView.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var vm = SignUpViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image("signUpImage")
                    .resizable()
                    .ignoresSafeArea()
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                    VStack(spacing: 16) {
                        Text("Create Account")
                            .font(.system(size: 45))
                            .bold()
                            .padding(.top, 60)
                        Text("Welcome! Enter your details and start \ncreating, collecting and selling games")
                            .font(.system(size: 16))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                        CustomTextField(bindingValue: $vm.username, image: "person", placeHolder: "Username")
                        CustomTextField(bindingValue: $vm.email, image: "envelope", placeHolder: "Email Adress")
                        CustomSecureTextField(bindingValue: $vm.password, image: "lock", placeHolder: "Password")
                        CustomSecureTextField(bindingValue: $vm.confirmPassword, image: "lock", placeHolder: "Confirm Password")
                        Button {
                            Task {
                                await vm.signUp()
                                print("SignUp")
                            }
                        } label: {
                            Text("Sign Up")
                                .fontDesign(.rounded)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding([.top, .bottom], 12)
                                .padding([.leading, .trailing], 72)
                                .background(Color.gray)
                                .cornerRadius(10)
                        }
                        .padding(.top)
                        .padding(.bottom, 20)
                        
                    }
                    .padding([.leading, .trailing])
                }
            }
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
