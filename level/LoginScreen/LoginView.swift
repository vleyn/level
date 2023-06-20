//
//  LoginView.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
         
        NavigationView {
            VStack {
                VStack {
                    Image("gamepad")
                        .resizable()
                        .frame(width: 150, height: 130)
                    Text("Level")
                        .bold()
                    Text("The largest gamestore in Belarus")
                }
                .padding(.top, 50)
                
                VStack(spacing: 18) {
                    Spacer()
                    CustomTextField(bindingValue: $vm.email, image: "envelope", placeHolder: "Email")
                    CustomSecureTextField(bindingValue: $vm.password, image: "lock", placeHolder: "Password")

                    Button {
                        print("forgot password")
                    } label: {
                        Text("Forgot password ?")
                    }
                }
                .padding([.leading, .trailing])
                VStack {
                    Button {
                        Task {
                            await vm.login()
                        }
                    } label: {
                        Text("Login")
                            .fontDesign(.rounded)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding([.top, .bottom], 13)
                            .padding([.leading, .trailing], 100)
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                    .padding(.top)

                    Divider()
                        .padding([.leading, .trailing], 50)
                    
                    HStack(spacing: 20) {
                        Button {
                            print("Google")
                        } label: {
                            Image("google.logo")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding(.top, 12)
                        }
                        
                        Button {
                            print("Apple")
                        } label: {
                            Image(systemName: "apple.logo")
                                .resizable()
                                .frame(width: 30, height: 36)
                                .foregroundColor(.black)
                        }
                        
                        Button {
                            print("Facebook")
                        } label: {
                            Image("facebook.logo")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding(.top, 12)
                        }
                    }
                    Spacer()
                    HStack {
                        Text("Dont have an account?")
                        Button {
                            print("SignUp")
                        } label: {
                            NavigationLink(destination: SignUpView()) {
                                Text("Sign up")
                            }
                        }
                    }
                    .padding(.top)
                }
                Spacer()
            }
            .fullScreenCover(isPresented: $vm.isPresented) {
                CustomTabbar()
            }
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }     
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
