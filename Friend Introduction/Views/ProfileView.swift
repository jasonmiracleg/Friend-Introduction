//
//  ContentView.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 07/05/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var justifiedTextHeight: CGFloat = .zero
    @State private var navigate = false

    let colors: [ColorPallete] = [
        ColorPallete(
            colorName: "Favorite Color",
            rgbValue: (red: 102 / 255, green: 189 / 255, blue: 229 / 255)
        )
    ]

    let descriptionText: String =
        "Theo is a final-year Visual Communication Design student with a decade of creative experience, especially with his longtime companion—Adobe. Outside the screen, he thrives on motion, often found cycling or running, even once conquering a 150km ride. At just his age, he’s already founded his own photography agency, joined the Apple Developer Academy 2025, and built a personal collection of camera gear. Design, speed, and vision—Theo lives at the intersection of all three."

    let columns = [
        GridItem(.adaptive(minimum: 80), spacing: 12)
    ]

    let personalityColumn = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    let personalities = [
        "Ambivert",
        "Intuitive",
        "Analytical",
        "Methodological",
    ]

    let interestBadges = [
        Badge(title: "Badminton", iconName: "figure.badminton"),
        Badge(title: "Cycling", iconName: "figure.outdoor.cycle"),
        Badge(title: "Running", iconName: "figure.run"),
        Badge(title: "Design", iconName: "paintbrush.pointed.fill"),
        Badge(title: "Photography", iconName: "camera.fill"),
        Badge(title: "Technology", iconName: "laptopcomputer"),

    ]

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 8) {
                        ZStack(alignment: .bottom) {
                            Image(.theo)
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    maxWidth: geometry.size.width,
                                    maxHeight: geometry.size.height * 0.5
                                )
                                .clipped()
                            VStack {
                                Button(action: {
                                    navigate = true
                                }) {
                                    Label("Get to Know Theo", systemImage: "")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    Color(
                                        red: colors[0].rgbValue.red,
                                        green: colors[0].rgbValue.green,
                                        blue: colors[0].rgbValue.blue
                                    )
                                )
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .padding(.horizontal, 16)
                                .padding(.bottom)
                                .navigationDestination(isPresented: $navigate) {
                                    SwipeCardView()
                                }
                                .navigationTitle("Profile")
                                .navigationBarHidden(true)
                            }
                        }
                        Group {
                            Group {
                                Text("Theodore Michael Budiono • 22")
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.top, 24)
                                Text("Theo, The, O - Surabaya")
                                    .font(.headline)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                    .padding(.bottom, 16)
                            }
                            Group {
                                Text("About")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                Text(
                                    descriptionText
                                )
                                .padding(.bottom, 16)
                            }
                            Group {
                                Text("Interests")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                LazyVGrid(columns: columns, alignment: .leading)
                                {
                                    ForEach(
                                        Array(interestBadges.enumerated()),
                                        id: \.1.id
                                    ) { index, badge in
                                        HStack {
                                            VStack {
                                                Image(
                                                    systemName: badge.iconName
                                                )
                                                .font(.system(size: 32))
                                                .padding(8)
                                                .clipShape(Circle())
                                                Spacer()
                                                Text(badge.title)
                                                    .font(.callout)
                                            }
                                        }
                                        .frame(width: 100)
                                    }
                                }
                                .padding(.bottom, 16)
                            }
                            Group {
                                Text("Personality Traits")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                Text(
                                    "Scratch the Card to Reveal His Personalities"
                                )
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 4)
                                PersonalityCards()
                            }
                        }
                        .padding(.trailing, 24)
                        .padding(.leading, 24)
                    }
                    .padding(.bottom, 32)
                }
                .ignoresSafeArea(.all)
            }
        }
    }
}

#Preview {
    ProfileView()
}
