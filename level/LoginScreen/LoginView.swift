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
            
            Spacer()

            VStack(spacing: 18) {
                CustomTextField(bindingValue: $vm.email, image: "envelope", placeHolder: "Email")
                CustomSecureTextField(bindingValue: $vm.password, image: "lock", placeHolder: "Password")

                Button {
                    print("forgot password")
                } label: {
                    Text("Forgot your password?")
                }
            }
            Spacer()
            VStack {
                Button {
                    Task {
                        await vm.login()
                        print("Login success")
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

                Divider()
                    .padding([.leading, .trailing], 50)

                Button {
                    print("Google")
                } label: {
                    Text("Enter google")
                        .fontDesign(.rounded)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 12)
                        .padding([.leading, .trailing], 72)
                        .background(Color.gray)
                        .cornerRadius(8)
                }
                .padding(.top)

                
                Button {
                    print("Apple")
                } label: {
                    Text("Enter apple")
                        .fontDesign(.rounded)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 12)
                        .padding([.leading, .trailing], 76)
                        .background(Color.gray)
                        .cornerRadius(8)
                }
            }
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
