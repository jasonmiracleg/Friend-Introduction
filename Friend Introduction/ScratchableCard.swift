import Foundation
//
//  ScratchableCard.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 09/05/25.
//
import SwiftUI

struct ScratchableCard: View {
    @State private var fadePoints: [FadePoint] = []

    let text: String = "INTJ"
    let fadeDuration: TimeInterval = 0.25
    let radius: CGFloat = 20
    let width: CGFloat = 175
    let height: CGFloat = 100

    @State private var revealed: Bool = false
    @State private var dragOffset = CGSize.zero

    let color: Color = .blue

    var body: some View {
        ZStack {
            // Cover layer
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 220 / 255, green: 220 / 255, blue: 220 / 255))
                .frame(width: width, height: height)

            // Base Layer
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)

                Text(text)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .frame(width: width, height: height)
            .mask( // Show the Actual Contente in the Drawn Path
                Group {
                    // Checking Revealed
                    if revealed {
                        Rectangle()
                    } else {
                        // Enables to Draw Shapes on the Path
                        Canvas { context, size in
                            for (ix, point) in fadePoints.enumerated() {
                                
                                // Gradient for the Fill
                                let gradient = Gradient(stops: [
                                    .init(color: .white, location: 0),
                                    .init(
                                        color: .white.opacity(0),
                                        location: 1
                                    ),
                                ])
                                
                                // Create and Fill the Ellipse
                                context.fill(
                                    Path(
                                        ellipseIn: CGRect(
                                            x: point.location.x - radius,
                                            y: point.location.y - radius,
                                            width: radius * 3,
                                            height: radius * 3
                                        )
                                    ),
                                    with: .radialGradient(
                                        gradient,
                                        center: point.location,
                                        startRadius: 0,
                                        endRadius: radius + CGFloat(ix + 1)
                                    )
                                )
                            }
                        }
                    }
                }
            )
            .gesture(
                DragGesture(minimumDistance: 0) // Activating the Drag Gesture
                    .onChanged({ value in
                        // Adding the Location in the Fade Points Array by Creating a FadePoint Data Entry
                        fadePoints.append(
                            FadePoint(
                                location: value.location,
                                timestamp: Date()
                            )
                        )
                        
                        // Trigger the Checking Asynchronously
                        DispatchQueue.main.async {
                            checkRevealProgress()
                        }
                    })
            )
        }
    }

    // Reveal the Whole Card
    func checkRevealProgress() {
        let scratchedArea = CGFloat(fadePoints.count) * .pi * radius * radius
        let totalArea = width * height
        let progress = scratchedArea / totalArea
        if progress > 20 {
            revealed = true
        }
    }

}

struct FadePoint: Identifiable {
    let id = UUID()
    var location: CGPoint
    var timestamp: Date
}

#Preview {
    ScratchableCard()
}
