//
//  GameRow.swift
//  RAWGapp
//
//  Created by Enygma System on 12/04/22.
//

import SwiftUI

struct GameRow: View {
    var gameData: GameModel
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text(gameData.name)
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(gameData.releaseDate)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.bottom, 20.0)
                }
                .padding(.leading, 20.0)
                Spacer()
            }
            HStack {
                StarsView(rating: gameData.rating)
            }
            .padding([.top, .trailing], 20.0)
        }
//        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(
            Color.white
                .overlay(
                    CachedAsyncImage(url: URL(string: gameData.imageBackground ?? "")) { image in
                        image
                            .resizable()
        //                    .aspectRatio(contentMode: .fill)
                            .scaledToFill()
                            .overlay(TintOverlay().opacity(0.75))
                            .shadow(color: .gray, radius: 5, x: 2, y: 2)
                    } placeholder: {
                        Color.gray.opacity(0.1)
                            .cornerRadius(25)
                            .shadow(color: .gray, radius: 5, x: 2, y: 2)
                    }
                )
                .clipped()
                .cornerRadius(20)
        )
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(gameData: gameTestData)
    }
}
