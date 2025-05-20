//
//  SwipeCard.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 14/05/25.
//
import SwiftUI

struct SwipeCardView: View {
    private let contents = [
        (
            "Milestones",
            "I bought my own camera and lenses\n\nPart of Apple Developer Academy\n\nI established my own photography agency"
        ),
        ("Dream", "I want to be Tour de France Photographer"),
        (
            "Fun Facts",
            "I already used Adobe for 10 years\n\nI cycled 150km in one go\n\n I used to enroll bike races"
        ),
        ("Who am I?", "Cyclist\n\nDesigner\n\nPhotographer"),
        (
            "People often misunderstand me",
            "They think I'm mean, like kinda I am, but I'm at that mean\nCome on😜"
        ),
        (
            "If my life were a movie, what would the title be?",
            "Tenet\nMy life is generally confusing for most people looking into it, but deep down I'm just having fun"
        ),
        (
            "One thing I love and learn someday",
            "Analog Circuit Design and IoT\nI mean, it's not beyond my interest and I'll definitely learn something new"
        ),
        (
            "Random thing I know too much",
            "Probably cycling\n(I watch cycling races all year around)"
        ),
        (
            "Things I do in my free time",
            "Cycling, gym, badminton, and confusing myself with obscure knowledge far beyond my field of design (Data Science, Programming, History, and Engineering)"
        ),
        (
            "Agency",
            "I did mention about me establishing my own agency. To be honest, It took me several years to find the right people to work with. But,I'm glad I did because I'm really proud of what we've accomplished. Even, my members are really happy with working here"
        ),
    ]

    @State private var topCardIndex = 0
    @State private var swipedCardCount = 10
    @State private var resetTrigger = UUID()
    @State private var likes = 0

    var body: some View {
        VStack {
            Text("\(swipedCardCount) Left")
                .padding(.bottom, 24)
                .font(.title3)
                .bold(true)
            ZStack {
                Text(likes > 5 ? "You seem to have a chemistry with Theo 😜" : "Try to get know him better regardless of your dislike🥺")
                    .padding(.horizontal, 64)
                    .multilineTextAlignment(.center)
                ForEach(contents.indices.reversed(), id: \.self) {
                    index in
                    GetToKnowCard(
                        title: contents[index].0,
                        content: contents[index].1,
                        onSwiped: {
                            if index == topCardIndex
                                && topCardIndex < self.contents.count
                                    - 1
                            {
                                topCardIndex += 1
                            }
                            swipedCardCount -= 1
                        },
                        onSwipeDirection: { direction in
                            if direction == .right {
                                likes += 1
                            }
                        },
                        resetTrigger: resetTrigger
                    )
                    .blur(radius: index == topCardIndex ? 0 : 0.5)
                    .allowsHitTesting(index == topCardIndex)
                }
            }
            .onAppear {
                topCardIndex = 0
                swipedCardCount = contents.count
                resetTrigger = UUID()
            }

            Text(
                "Tap the card to flip the card and learn more\nSwipe left if you dislike me, swipe right if you like me"
            )
            .padding(.top, 16)
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SwipeCardView()
}
