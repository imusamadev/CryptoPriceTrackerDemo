//
//  WelcomeView.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/12/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Image("phone")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 469)
                        .padding(.top, 30)

                    VStack(alignment: .leading) {
                        Text("Your personal crypto wallet")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)

                        Text("It's secure and supports nearly a hundred crypto currencies")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                    }
                    .padding(.horizontal, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    NavigationLink(destination: ContentView()) {
                        HStack {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 20)
                        .frame(width: 347, height: 52)
                        .background(Color(red: 0/255, green: 244/255, blue: 200/255))
                        .cornerRadius(12)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

#Preview{
    WelcomeView()
}
