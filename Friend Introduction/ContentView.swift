//
//  ContentView.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 07/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var justifiedTextHeight: CGFloat = .zero
    let colors: [ColorPallete] = [
        ColorPallete(
            colorName: "Favorite Color",
            rgbValue: (red: 102 / 255, green: 189 / 255, blue: 229 / 255)
        )
    ]

    let badgeColor = Color(red: 102 / 255, green: 189 / 255, blue: 229 / 255)

    let interestBadges = [
        Badge(title: "Design", iconName: "paintbrush.pointed.fill"),
        Badge(title: "Sport", iconName: "figure.badminton"),
        Badge(title: "Technology", iconName: "laptopcomputer"),
    ]

    let hobbyBadges = [
        Badge(title: "Running", iconName: "figure.run"),
        Badge(title: "Cycling", iconName: "figure.outdoor.cycle"),
        Badge(title: "Sleeping", iconName: "bed.double.fill"),
    ]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 8) {
                    ZStack(alignment: .bottomTrailing) {
                        Image(.theo)
                            .frame(maxWidth: geometry.size.width)
                        Button(action: {}) {
                            Label("Highlights", systemImage: "arrow.up")
                        }
                        .padding()
                        .background(
                            Color(
                                red: colors[0].rgbValue.red,
                                green: colors[0].rgbValue.green,
                                blue: colors[0].rgbValue.blue
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.trailing)
                        .padding(.bottom)
                    }
                    Group {
                        Group {
                            Text("Theodore Michael Budiono • 22")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.top, 4)
                            Text("Theo, The, O - Surabaya")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 24)
                        }
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
                            .padding(.bottom, 24)
                        }
                        Group {
                            Text("Interests")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                ForEach(
                                    Array(interestBadges.enumerated()),
                                    id: \.1.id
                                ) { index, badge in
                                    HStack {
                                        VStack(spacing: 8) {
                                            Image(systemName: badge.iconName)
                                                .font(.system(size: 32))
                                                .padding(12)
                                                .background(
                                                    badgeColor.opacity(0.2)
                                                )
                                                .clipShape(Circle())
                                            Text(badge.title)
                                                .font(.callout)
                                        }
                                        if index < 2 {
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 24)
                        }
                        Group {
                            Text("Hobbies")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                ForEach(
                                    Array(hobbyBadges.enumerated()),
                                    id: \.1.id
                                ) { index, badge in
                                    HStack {
                                        VStack(spacing: 8) {
                                            Image(systemName: badge.iconName)
                                                .font(.system(size: 32))
                                                .padding(12)
                                                .background(
                                                    badgeColor.opacity(0.2)
                                                )
                                                .clipShape(Circle())
                                            Text(badge.title)
                                                .font(.callout)
                                        }
                                        if index < 2 {
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.trailing, 16)
                    .padding(.leading, 16)
                }
                .padding(.bottom, 32)
            }
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}
