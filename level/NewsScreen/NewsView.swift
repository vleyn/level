//
//  NewsView.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import SwiftUI
import AVKit
import Kingfisher

struct NewsView: View {
    
    @StateObject var vm = NewsViewModel()
    
    @State var currentNews: GameNews?
    @State var showDetailsPage: Bool = false
    
    @Namespace var animation
    
    @State var animateView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            if vm.news.isEmpty {
                ProgressView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Wednesday 19 July")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                                Text("Today")
                                    .font(.largeTitle.bold())
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .opacity(showDetailsPage ? 0 : 1)
                        ForEach(vm.news, id: \.id) { news in
                            Button {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    currentNews = news
                                    showDetailsPage = true
                                }
                            } label: {
                                newsView(item: news)
                                    .scaleEffect(currentNews?.id == news.id && showDetailsPage ? 1 : 0.93)
                            }
                            .buttonStyle(ScaledButtonStyle())
                            .opacity(showDetailsPage ? (currentNews?.id == news.id ? 1 : 0) : 1)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }

        .overlay {
            if let currentNews = currentNews, showDetailsPage {
                detailView(item: currentNews)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.normalBW)
                .frame(height: animateView ? nil : 350, alignment: .top)
                .scaleEffect(animateView ? 1 : 0.93)
                .opacity(animateView ? 1 : 0)
                .ignoresSafeArea()
        }
        .task {
            await vm.fetchNews()
        }
    }
    
    @ViewBuilder
    func newsView(item: GameNews) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack(alignment: .topLeading) {
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    KFImage(URL(string: item.image ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 15))
                }
                .frame(height: 250)
                
                LinearGradient(colors: [
                    .black.opacity(0.5),
                    .black.opacity(0.2),
                    .clear
                ], startPoint: .top, endPoint: .bottom)
            }
            VStack(alignment: .leading) {
                Text(item.header ?? "")
                    .multilineTextAlignment(.leading)
                    .font(.headline)
            }
            .foregroundColor(.primary)
            .padding([.horizontal, .bottom])
        }
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.indigo)
        )
        .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    func detailView(item: GameNews) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                newsView(item: item)
                    .scaleEffect(animateView ? 1 : 0)
                VStack(alignment: .leading, spacing: 15) {
                    Text(item.shortDescription ?? "")
                        .font(.title2.bold())
                    Text(item.longDescription ?? "")
                    HStack {
                        Text("Author: \(item.author ?? "")")
                        Spacer()
                        Text("Views: \(item.numberOfReads ?? 0)")
                    }
                }
                .padding(.horizontal)
                .offset(y: scrollOffset > 0 ? scrollOffset : -scrollOffset)
                .opacity(animateContent ? 1 : 0)
                .scaleEffect(animateView ? 1 : 0, anchor: .top)
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
        }
        .overlay(alignment: .topTrailing, content: {
            Button {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = false
                    animateContent = false
                }
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                    currentNews = nil
                    showDetailsPage = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .padding(.top, safeArea().top)
            .opacity(animateView ? 1 : 0)
        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                animateView = true
            }
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.1)) {
                animateContent = true
            }
        }
        .transition(.identity)
    }
    
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

extension View {
    func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
    
    func offset(offset: Binding<CGFloat>) -> some View {
        return self
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                }
                .onPreferenceChange(OffsetKey.self) { value in
                    offset.wrappedValue = value
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
