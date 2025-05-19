//
//  SwipeCard.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 14/05/25.
//
import SwiftUI

struct SwipeCard: View {
    private let contents = [
        ("Agency", "I did mention about me establishing my own agency. To be honest, It took me several years to find the right people to work with. But,I'm glad I did because I'm really proud of what we've accomplished. Even, my members are really happy with working here"),
        ("Milestones", "I bought my own camera and lenses\n\nPart of Apple Developer Academy\n\nI established my own photography agency"),
        ("Dream", "I want to be Tour de France Photographer"),
        ("Fun Facts", "I already used Adobe for 10 years\n\nI cycled 150km in one go\n\n I used to enroll bike races"),
        ("Who am I?", "Cyclist\n\nDesigner\n\nPhotographer"),
        ("People often misunderstand me", "They think I'm mean, like kinda I am, but I'm at that mean\nCome on😜"),
        ("If my life were a movie, what would the title be?", "Tenet\nMy life is generally confusing for most people looking into it, but deep down I'm just having fun"),
        ("One thing I love and learn someday","Analog Circuit Design and IoT\nI mean, it's not beyond my interest and I'll definitely learn something new"),
        ("Random thing I know too much", "Probably cycling\n(I watch cycling races all year around)"),
        ("Things I do in my free time", "Cycling, gym, badminton, and confusing myself with obscure knowledge far beyond my field of design (Data Science, Programming, History, and Engineering)")
    ]
    
    @State private var topCardIndex = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                ZStack {
                    ForEach(contents.indices.reversed(), id: \.self) { index in
                        GetToKnowCard(
                            title: contents[index].0,
                            content: contents[index].1,
                            onSwiped: {
                                if index == topCardIndex && topCardIndex < self.contents.count - 1 {
                                    topCardIndex += 1
                                }
                            }
                        )
                            .blur(radius: index == topCardIndex ? 0 : 8)
                            .shadow(radius: index == topCardIndex ? 4 : 0)
                            .allowsHitTesting(index == topCardIndex)
                    }
                }
            }
        }
    }
}


#Preview {
    SwipeCard()
}
