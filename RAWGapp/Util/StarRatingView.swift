//
//  StarRatingView.swift
//  RAWGapp
//
//  Created by Enygma System on 12/04/22.
//

import SwiftUI

struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int = 5

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating) { _ in
                Image(systemName: "star.fill")
            }
        }

        stars.overlay(
            GeometryReader { geometry in
                let width = rating / CGFloat(maxRating) * geometry.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
                .mask(stars)
        )
        .foregroundColor(.gray)
    }
}
