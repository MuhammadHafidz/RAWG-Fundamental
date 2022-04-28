//
//  DetailView.swift
//  RAWGapp
//
//  Created by Enygma System on 13/04/22.
//

import SwiftUI

struct DetailView: View {
    var id: Int
    @State var isHideLoader: Bool = true
    @State var showErrorAlert = false
    @State var errorMessage = ""
    @State var gameData: GameDetailModel?
    @State var isFavorite: Bool = false
    @State var gameProvider: GameProvider = GameProvider()
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.60).ignoresSafeArea()
            ScrollView {
                if gameData != nil {
                    VStack(alignment: .leading) {
                        if gameData?.image != nil {
                            CachedAsyncImage(url: URL(string: gameData?.image ?? "")) { image in
                                image
                                    .resizable()
                                    .frame(height: 200)
                                    .cornerRadius(20)
                                    .shadow(color: .white, radius: 4)
                                    .padding(.top, 20)
                            } placeholder: {
                                Color.gray.opacity(0.1)
                                    .cornerRadius(25)
                                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
                            }
                        }
                        Text(gameData?.name ?? "-")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.vertical, 8.0)
                        StarsView(rating: gameData?.rating ?? 0)
                        HStack {
                            VStack(alignment: .center) {
                                Text("Metascore")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                Text((gameData?.metacritic != nil) ? String((gameData?.metacritic)!): "-")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.top, 4.0)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            VStack(alignment: .center) {
                                Text("Playtime")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                Text((gameData?.playtime != nil) ? String((gameData?.playtime)!): "-")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.top, 4.0)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            VStack(alignment: .center) {
                                Text("Rating")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                Text((gameData?.esrbRating) ?? "-")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.top, 4.0)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }.padding(.top, 20)
                        Group {
                            Text("Release Date")
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .bold))
                                .padding(.top, 8.0)
                            Text(gameData?.releaseDate ?? "")
                                .foregroundColor(Color.white)
                                .font(.system(size: 12, weight: .regular))
                                .padding(.top, 1.0)
                            if gameData?.platforms != nil {
                                Text("Platform")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(gameData?.platforms ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                            if gameData?.genres != nil {
                                Text("Genre")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(gameData?.genres ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                        }
                        Group {
                            if gameData?.developers != nil {
                                Text("Developer")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(gameData?.developers ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                            if gameData?.publishers != nil {
                                Text("Publisher")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(gameData?.publishers ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                            if gameData?.description != nil {
                                Text("Description")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.top, 4.0)
                                Text(gameData?.description ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 1.0)
                            }
                        }
                        if gameData?.urlWeb != nil {
                            Button {
                                let url = URL(string: (gameData?.urlWeb)!)
                                if UIApplication.shared.canOpenURL(url!) {
                                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                                }
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Open Website")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue.cornerRadius(10))
                                        .cornerRadius(10)
                                    Spacer()
                                }
                            }.padding(.top)
                        }
                    }
                    .navigationBarItems(
                        trailing:
                            HStack {
                                if isFavorite {
                                    Button {
                                        deleteFavorite()
                                    } label: {
                                        Image(systemName: "heart.fill").imageScale(.large)
                                            .tint(.blue)
                                    }
                                } else {
                                    Button {
                                        addFavorite()
                                    } label: {
                                        Image(systemName: "heart").imageScale(.large)
                                            .tint(.blue)
                                    }
                                }
                            }
                    )
                    .navigationBarTitle("", displayMode: .inline)
                    .padding([.leading, .bottom, .trailing], 20)
                }
            }
            IndicatorView(tintColor: .white, scaleSize: 2.0)
                .padding(.bottom).hidden(isHideLoader)
        }
        .onAppear {
            isHideLoader = false
            getDetailGame(id: String(id)) { res in
                isHideLoader = true
                gameData = res
            } error: { err in
                isHideLoader = true
                errorMessage = err
                self.showErrorAlert.toggle()
            }
            getFavorite()
        }
        .alert(isPresented: self.$showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .cancel())
        }
        .background(
            CachedAsyncImage(url: URL(string: gameData?.imageBackground ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
            } placeholder: {
                Color.gray.opacity(0.1)
                    .cornerRadius(25)
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
            }
        )
    }
    func addFavorite() {
        gameProvider.createGame(gameData!) { success in
            if success {
                isFavorite = true
            }
        }
    }

    func deleteFavorite() {
        gameProvider.deleteGame(id) { success in
            if success {
                isFavorite = false
            }
        }
    }

    func getFavorite() {
        gameProvider.getGame(id) { game in
            if game != nil {
                isFavorite = true
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 3498)
    }
}
