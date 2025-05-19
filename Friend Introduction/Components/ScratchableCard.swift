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

    let text: String
    let fadeDuration: TimeInterval = 0.25
    let radius: CGFloat = 20
    let height: CGFloat = 75

    @State private var revealed: Bool = false
    @State private var dragOffset = CGSize.zero

    let color: Color

    var body: some View {
        ZStack {
            // Cover layer
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 102 / 255, green: 189 / 255, blue: 229 / 255))
                .opacity(0.3)
                .frame(maxWidth: .infinity, maxHeight: height)

            // Base Layer
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)

                Text(text)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, minHeight: height)
            .mask( // Show the Actual Content in the Drawn Path
                Group {
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
                                            width: radius * 2,
                                            height: radius * 2
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
                        
                    })
            )
        }
    }
}

struct FadePoint: Identifiable {
    let id = UUID()
    var location: CGPoint
    var timestamp: Date
}

#Preview {
    ScratchableCard(text: "INFJ", color: .blue)
        .padding(20)
}
