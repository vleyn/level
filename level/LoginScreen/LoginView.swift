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
        
        NavigationStack {
            VStack {
                logoView
                loginForm
                loginButtons
            }
            .fullScreenCover(isPresented: $vm.isPresented) {
                TabBarView()
            }
            .alert("Error", isPresented: $vm.isAlert) {
                Button("Cancel", role: .cancel) { }
            } message: {
                Text(vm.errorText)
            }
        }
    }
    
    private var logoView: some View {
        VStack {
            Image("gamepad")
                .resizable()
                .frame(width: 150, height: 130)
            Text("Level")
                .bold()
            Text("The largest gamestore in Belarus")
        }
        .padding(.top, 50)
    }
    
    private var loginForm: some View {
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
        .padding(.horizontal)
    }
    
    private var loginButtons: some View {
        VStack {
            Button {
                vm.login()
            } label: {
                Text("Login")
                    .fontDesign(.rounded)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 13)
                    .padding(.horizontal, 100)
                    .background(Color.gray)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Divider()
                .padding(.horizontal, 50)
            
            HStack(spacing: 20) {
                Button {
                    print("Google sign in")
                } label: {
                    Image("google.logo")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.top, 12)
                }
                
                Button {
                    print("Apple sign in")
                } label: {
                    Image(systemName: "apple.logo")
                        .resizable()
                        .frame(width: 30, height: 36)
                        .foregroundColor(.black)
                }
                
                Button {
                    print("Facebook sign in")
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
                } label: {
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up")
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
