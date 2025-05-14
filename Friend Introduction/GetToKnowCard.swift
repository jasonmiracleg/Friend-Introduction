//
//  GetToKnowCard.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 14/05/25.
//

import SwiftUI

struct GetToKnowCard: View {
    var title: String
    var content: String
    let durationAndDelay: CGFloat = 0.5
    @State private var offset = CGSize.zero
    @State private var color: Color = .blue
    @State var backDegree = 90.0
    @State var frontDegree = 0.0
    @State var isFlipped: Bool = false

    var body: some View {
        ZStack {
            frontCard(color: color, title: title, degree: $frontDegree)
            backCard(color: color, content: content, degree: $backDegree)
        }
        .offset(x: offset.width, y: offset.height * 0.2)
        .rotationEffect(.degrees(Double(offset.width / 60)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                        changeColor(width: offset.width)
                    }
                }
        )
        .onTapGesture {
            flipCard()
        }
    }

    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }

    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...500:
            color = .green
        default:
            color = .blue
        }
    }

    func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(
                .linear(duration: durationAndDelay).delay(durationAndDelay)
            ) {
                backDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(
                .linear(duration: durationAndDelay).delay(durationAndDelay)
            ) {
                frontDegree = 0
            }
        }
    }

}

struct frontCard: View {
    let color: Color
    let title: String

    @Binding var degree: Double

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 500)
                .border(.white, width: 6.0)
                .cornerRadius(4)
                .foregroundColor(color)
                .shadow(radius: 4)
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct backCard: View {
    let color: Color
    let content: String

    @Binding var degree: Double

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 500)
                .border(.white, width: 6.0)
                .cornerRadius(4)
                .foregroundColor(color)
                .shadow(radius: 4)
            HStack {
                Text(content)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    GetToKnowCard(title: "Hobby", content: "Lorem Ipsum")
}
