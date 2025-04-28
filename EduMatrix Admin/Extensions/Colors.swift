//
//  Colors.swift
//  EduMatrix Admin
//
//  Created by Ankit Rajput on 15/07/24.
//

import Foundation
import SwiftUI

extension Color {
    static let primaryColor = Color(hex: "#25A2FF")
    static let secondaryColor = Color(hex: "#FFFFFF")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
