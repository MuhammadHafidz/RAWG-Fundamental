//
//  HomeScreen.swift
//  RAWGapp
//
//  Created by Enygma System on 12/04/22.
//

import SwiftUI

struct HomeScreen: View {
    @State var isHideLoader: Bool = true
    @State var showErrorAlert = false
    @State var errorMessage = ""
    @State var searchText = ""
    @State var listData = [GameModel]()
    @State var gamesData: [GameModel] = [GameModel]()
    @State var searchGameData: [GameModel] = [GameModel]()

    var body: some View {
        ZStack {
            NavigationView {
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
                .navigationBarTitle("RAWG", displayMode: .automatic)
                .navigationBarItems(
                    trailing:
                        HStack {
                            Button {
                                print("Open Favorite")
                            } label: {
                                NavigationLink(destination: FavoriteScreen()) {
                                    Image(systemName: "heart.fill").imageScale(.large)
                                        .tint(.black)
                                }
                            }
                            Button {
                                print("Open Profile")
                            } label: {
                                NavigationLink(destination: ProfileScreen()) {
                                    Image(systemName: "person.crop.circle.fill").imageScale(.large)
                                        .tint(.black)
                                }
                            }
                        }
                )
                .onAppear {
                    if listData.isEmpty {
                        isHideLoader = false
                        getGames { res in
                            isHideLoader = true
                            gamesData = res.results!
                            listData = gamesData
                        } error: { err in
                            isHideLoader = true
                            errorMessage = err
                            self.showErrorAlert.toggle()
                        }
                    }
                }
                .alert(isPresented: self.$showErrorAlert) {
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .cancel())
                }
            }
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search Game")
            .onChange(of: searchText) { value in
                if !value.isEmpty {
                    listData = []
                    isHideLoader = false
                } else {
                    listData = gamesData
                }
            }
            .onSubmit(of: .search) {
                getSearchGame(strQuery: searchText) { res in
                    isHideLoader = true
                    searchGameData = res.results!
                    listData = searchGameData
                } error: { err in
                    isHideLoader = true
                    errorMessage = err
                    self.showErrorAlert.toggle()
                }
            }
            IndicatorView(tintColor: .black, scaleSize: 2.0)
                .padding(.bottom).hidden(isHideLoader)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
