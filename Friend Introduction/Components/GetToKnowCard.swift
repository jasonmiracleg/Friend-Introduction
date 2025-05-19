//
//  GetToKnowCard.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 14/05/25.
//

import SwiftUI

enum swipeDirection {
    case left, right
}

struct GetToKnowCard: View {
    var title: String
    var content: String
    let durationAndDelay: CGFloat = 0.5
    var onSwiped: (() -> Void)? = nil
    var onSwipeDirection: ((swipeDirection) -> Void)? = nil
    var resetTrigger: UUID? = nil
    private let initialColor = Color(
        red: 102 / 255,
        green: 189 / 255,
        blue: 229 / 255
    )
    @State private var offset = CGSize.zero
    @State private var color: Color
    @State var backDegree = 90.0
    @State var frontDegree = 0.0
    @State var isFlipped: Bool = false
    @State private var showFlipAlert = false
    @State private var lastTrigger = UUID()

    init(
        title: String,
        content: String,
        onSwiped: (() -> Void)? = nil,
        onSwipeDirection: ((swipeDirection) -> Void)? = nil,
        resetTrigger: UUID? = nil
    ) {
        self.title = title
        self.content = content
        self.onSwiped = onSwiped
        self.onSwipeDirection = onSwipeDirection
        self.resetTrigger = resetTrigger
        _color = State(initialValue: initialColor)
    }

    var body: some View {
        ZStack {
            Card(
                color: color,
                content: title,
                font: .title,
                degree: $frontDegree
            )
            Card(
                color: color,
                content: content,
                font: .body,
                degree: $backDegree
            )
            .padding(.horizontal, 20)
        }
        .offset(x: offset.width, y: offset.height * 0.2)
        .rotationEffect(.degrees(Double(offset.width / 60)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if isFlipped {
                        showFlipAlert = true
                    } else {
                        withAnimation(.easeInOut) {
                            offset = gesture.translation
                            changeColor(width: offset.width)
                        }
                    }
                }
                .onEnded { _ in
                    if !isFlipped {
                        withAnimation(.easeOut) {
                            swipeCard(width: offset.width)
                            changeColor(width: offset.width)
                        }
                    }
                }
        )
        .alert(
            "Please flip the card back before swiping",
            isPresented: $showFlipAlert
        ) {
            Button("OK", role: .cancel) {}
        }
        .onChange(of: resetTrigger) {
            withAnimation(.easeOut(duration: 0.3)) {
                offset = .zero
                color = color
                frontDegree = 0
                backDegree = 90
                isFlipped = false
            }
        }
        .onTapGesture {
            flipCard()
        }
    }

    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            onSwipeDirection?(.left)
            onSwiped?()
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            onSwipeDirection?(.right)
            onSwiped?()
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
            color = initialColor
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

    func resetCardState() {
        withAnimation(.easeOut(duration: 0.3)) {
            offset = .zero
            color = color
            frontDegree = 0
            backDegree = 90
            isFlipped = false
        }
    }
}

struct Card: View {
    let color: Color
    let content: String
    let font: Font

    @Binding var degree: Double

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 500)
                .cornerRadius(4)
                .foregroundColor(color)
                .shadow(radius: 2)
            HStack {
                Spacer()
                Text(content)
                    .font(font)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 64)
                Spacer()
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    GetToKnowCard(title: "Hobby", content: "Lorem Ipsum")
}
