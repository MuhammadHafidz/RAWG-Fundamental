//
//  Color+Extensions.swift
//  RAWGapp
//
//  Created by Enygma System on 12/04/22.
//

import Foundation
import SwiftUI

extension Color {
    static var gradient: [Color] {
        return [
            Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 0.2),
            Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 0.5),
            Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 0.7),
            Color(red: 5/255, green: 5/255, blue: 5/255, opacity: 1.0)
        ]
    }
}

func hexStringToUIColor(hex: String) -> UIColor {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
        cString.remove(at: cString.startIndex)
    }

    if cString.count != 6 {
        return UIColor.gray
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
