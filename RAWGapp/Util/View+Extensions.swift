//
//  View+Extensions.swift
//  RAWGapp
//
//  Created by Enygma System on 12/04/22.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func hidden(_ hide: Bool) -> some View {
        switch hide {
        case true : self.hidden()
        case false : self
        }
    }
}

struct TintOverlay: View {
    var body: some View {
        ZStack {
            Text(" ")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: Color.gradient), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .cornerRadius(25)
    }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
}
