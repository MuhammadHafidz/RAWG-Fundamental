//
//  ProfileScreen.swift
//  RAWGapp
//
//  Created by Enygma System on 12/04/22.
//

import SwiftUI

struct ProfileScreen: View {
    @State var nama: String = ProfileModel.name
    @State var email: String = ProfileModel.email
    @State var imageUrl: String = ProfileModel.image
    @State var usernameIg: String = ProfileModel.usernameIg
    @State var urlIg: String = ProfileModel.urlIg
    @State var usernameGithub: String = ProfileModel.usernameGithub
    @State var urlGithub: String = ProfileModel.urlGithub
    @State var usernameLinkd: String = ProfileModel.usernameLinkd
    @State var urlLinkd: String = ProfileModel.urlLinkd
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    if imageUrl == "" {
                        Image("my-photo")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .shadow(color: .white, radius: 10)
                            .padding()
                    } else {
                        CachedAsyncImage(url: URL(string: imageUrl )) { image in
                            image
                                .resizable()
                                .frame(width: 200, height: 200)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .shadow(color: .white, radius: 10)
                                .padding()
                        } placeholder: {
                            Color.gray.opacity(0.1)
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .padding()
                        }
                    }
                    Text(nama)
                        .font(.title)
                        .fontWeight(.medium)
                    Text(email)
                        .font(.footnote)
                    Text("Follow Me :")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                    VStack(alignment: .leading) {
                        Button {
                            UIApplication.shared.open(URL(string: urlIg)!)
                        } label: {
                            HStack {
                                Image("instagram").foregroundColor(.black)
                                Text("@"+usernameIg)
                            }
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.top, 8)
                        Button {
                            UIApplication.shared.open(URL(string: urlGithub)!)
                        } label: {
                            HStack {
                                Image("github").foregroundColor(.black)
                                Text(usernameGithub)
                            }
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.top, 8)
                        Button {
                            UIApplication.shared.open(URL(string: urlLinkd)!)
                        } label: {
                            HStack {
                                Image("linkedin").foregroundColor(.black)
                                Text(usernameLinkd)
                            }
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.top, 8)
                    }
                    .navigationBarTitle("Profile", displayMode: .inline)
                    .toolbar {
                        Button {
                            print("Open Edit Profile")
                        } label: {
                            NavigationLink(destination: EditProfileView()) {
                                Text("Edit")
                            }
                        }
                    }
                }
                .padding(.top, 16)
                .onAppear {
                    ProfileModel.synchronize()
                    nama = ProfileModel.name
                    email = ProfileModel.email
                    imageUrl = ProfileModel.image
                    usernameIg = ProfileModel.usernameIg
                    urlIg = ProfileModel.urlIg
                    usernameGithub = ProfileModel.usernameGithub
                    urlGithub = ProfileModel.urlGithub
                    usernameLinkd = ProfileModel.usernameLinkd
                    urlLinkd = ProfileModel.urlLinkd
                }
            }
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
            .previewDevice("iPod touch (7th generation)")
    }
}
