//
//  NotificationsView.swift
//  level
//
//  Created by Владислав Мазуров on 15.07.23.
//

import SwiftUI
import Kingfisher

struct NotificationsView: View {
    
    @StateObject var vm = NotificationsViewModel()
    
    var body: some View {
        VStack {
            if vm.requests.isEmpty {
                VStack(spacing: 30) {
                    Image(systemName: "bell.slash")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.black)
                    Text("There is no friend requests yet")
                }
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(vm.requests, id: \.id) { request in
                            VStack {
                                HStack {
                                    KFImage(URL(string: request.avatar))
                                        .placeholder({
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.black)
                                        })
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                        .clipped()
                                        .cornerRadius(50)
                                        .overlay(RoundedRectangle(cornerRadius: 50)
                                            .stroke(.black, lineWidth: 2)
                                        )
                                        .padding(.leading)
                                    
                                    Text(request.nickname)
                                        .bold()
                                    Text("wants to be your friend!")
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 16) {
                                        Button {
                                            vm.proccessingRequest(action: .accept, request: request)
                                        } label: {
                                            Image(systemName: "person.fill.checkmark")
                                                .resizable()
                                                .frame(width: 30, height: 20)
                                                .foregroundColor(.green)
                                        }
                                        
                                        Button {
                                            vm.proccessingRequest(action: .decline, request: request)
                                        } label: {
                                            Image(systemName: "person.fill.xmark")
                                                .resizable()
                                                .frame(width: 30, height: 20)
                                                .foregroundColor(.red)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.vertical, 30)
                            .background(.gray)
                            .cornerRadius(24)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Incoming requests")
        .task {
            vm.fetchIncomingRequests()
        }
    }
    
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
