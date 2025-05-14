//
//  SwipeCard.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 14/05/25.
//
import SwiftUI

struct SwipeCard: View {
    private let contents = [("Achievement", "Get to know your friend's achievements"), ("Hobbies", "Get to know your friend's hobbies"), ("Travel", "Get to know your friend's travel"), ("Family", "Get to know your friend's family")]
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                ZStack {
                    ForEach(contents, id: \.0) { content in
                        GetToKnowCard(title: content.0, content: content.1)
                    }
                }
            }
        }
    }
}


#Preview {
    SwipeCard()
}
