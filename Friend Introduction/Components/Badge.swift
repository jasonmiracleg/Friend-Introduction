//
//  Badge.swift
//  Friend Introduction
//
//  Created by Jason Miracle Gunawan on 09/05/25.
//


import Foundation

struct Badge : Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
}
