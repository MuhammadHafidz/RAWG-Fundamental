//
//  IndicatorView.swift
//  RAWGapp
//
//  Created by Enygma System on 12/04/22.
//

import SwiftUI

struct IndicatorView: View {
    var tintColor: Color = .black
    var scaleSize: CGFloat = 1.0
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView()
    }
}
