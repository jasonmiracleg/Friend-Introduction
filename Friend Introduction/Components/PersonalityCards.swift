//
//  PersonalityCards.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 13/05/25.
//

import SwiftUI

struct PersonalityCards: View {
    let personalityColumn = [
        GridItem(.flexible())
    ]
    
    let personalities = [
        "Ambivert",
        "Intuitive",
        "Analytical",
        "Methodological",
    ]
    
    
    var body: some View {
        LazyVGrid(columns: personalityColumn, spacing: 16) {
            ForEach(personalities, id: \.self){ personality in
                ScratchableCard(text: personality, color: Color(red: 102 / 255, green: 189 / 255, blue: 229 / 255))                    
            }
        }
    }
}

#Preview {
    PersonalityCards()
}
