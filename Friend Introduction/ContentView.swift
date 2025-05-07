//
//  ContentView.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 07/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var justifiedTextHeight: CGFloat = .zero
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 4) {
                    ZStack(alignment: .bottomTrailing) {
                        Image(.theo)
                            .frame(maxWidth: geometry.size.width)
                        Button(action: {}) {
                            Label("Highlights", systemImage: "arrow.up")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.trailing)
                        .padding(.bottom)
                    }
                    Group {
                        Text("Theodore Michael Budiono • 22")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 8)
                        Text("Theo, The, O - Surabaya")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 24)
                    }
                    .padding(.trailing, 16)
                    .padding(.leading, 16)
                    Group {
                        Text("About")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        JustifiedText(
                            "Theo is a final-year Visual Communication Design student with a decade of creative experience, especially with his longtime companion—Adobe. Outside the screen, he thrives on motion, often found cycling or running, even once conquering a 150km ride. At just his age, he’s already founded his own photography agency, joined the Apple Developer Academy 2025, and built a personal collection of camera gear. Design, speed, and vision—Theo lives at the intersection of all three.",
                            dynamicHeight: $justifiedTextHeight
                        )
                        .frame(height: justifiedTextHeight)
                    }
                    .padding(.trailing, 16)
                    .padding(.leading, 16)
                }
                .padding(.bottom, 24)
            }
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}
