//
//  JustifiedText.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 08/05/25.
//
import SwiftUI

struct JustifiedText: UIViewRepresentable {
    @Binding var dynamicHeight: CGFloat
    private let text: String
    
    init(_ text: String, dynamicHeight: Binding<CGFloat>) {
        // Initialization
        self.text = text
        self._dynamicHeight = dynamicHeight
    }
    
    func makeUIView(context: Context) -> UITextView {
        // Justify the incoming text by creating the actual UIKit View
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = .label
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        
        // Remove padding
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        // Update all new input directly
        uiView.text = text
        
        let size = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: .greatestFiniteMagnitude))
        DispatchQueue.main.async {
            self.dynamicHeight = size.height
        }
    }
}
