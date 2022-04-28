//
//  FavoriteScreen.swift
//  RAWGapp
//
//  Created by Enygma System on 15/04/22.
//

import SwiftUI

struct FavoriteScreen: View {
    @State var isHideLoader: Bool = false
    @State var showErrorAlert = false
    @State var errorMessage = ""
    @State var listData = [GameModel]()
    @State var gameProvider: GameProvider = GameProvider()
    var body: some View {
        ZStack {
            List(listData, id: \.id) { game in
                ZStack {
                    GameRow(gameData: game)
                    NavigationLink(destination: DetailView(id: game.id)) {
                        EmptyView()
                    }
                }
                .padding(.all, 8.0)
                .listRowInsets(EdgeInsets())
                .listStyle(PlainListStyle())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.black.opacity(0))
            }
            .navigationBarTitle("Favorite", displayMode: .inline)
            .onAppear {
                isHideLoader = false
                gameProvider.getAllGames { games in
                    isHideLoader = true
                    listData = games
                }
            }
            .alert(isPresented: self.$showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .cancel())
            }
            IndicatorView(tintColor: .black, scaleSize: 2.0)
                .padding(.bottom).hidden(isHideLoader)
        }
    }
}

struct FavoriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteScreen()
    }
}
