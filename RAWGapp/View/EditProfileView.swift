//
//  EditProfile.swift
//  RAWGapp
//
//  Created by Enygma System on 15/04/22.
//

import SwiftUI

struct EditProfileView: View {
    @State var nama: String = ProfileModel.name
    @State var email: String = ProfileModel.email
    @State var imageUrl: String = ProfileModel.image
    @State var usernameIg: String = ProfileModel.usernameIg
    @State var urlIg: String = ProfileModel.urlIg
    @State var usernameGithub: String = ProfileModel.usernameGithub
    @State var urlGithub: String = ProfileModel.urlGithub
    @State var usernameLinkd: String = ProfileModel.usernameLinkd
    @State var urlLinkd: String = ProfileModel.urlLinkd
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("Nama")
                        .font(.caption)
                    TextField("Nama", text: $nama)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                }
                Group {
                    Text("Image - (Online URL)")
                        .font(.caption)
                    TextField("ex: https://www.google.com/hafidz.jpeg", text: $imageUrl)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .keyboardType(.URL)
                }
                Group {
                    Text("Email")
                        .font(.caption)
                    TextField("ex: h_vdz@live.com", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                }
                Group {
                    Text("Username Instagram - (Without @)")
                        .font(.caption)
                    TextField("ex: mhafidzam", text: $usernameIg)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                }
                Group {
                    Text("URL Instagram")
                        .font(.caption)
                    TextField("ex: https://www.instagram.com/mhafidzam", text: $urlIg)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .keyboardType(.URL)
                }
                Group {
                    Text("Username Github ")
                        .font(.caption)
                    TextField("ex: mhafidzam", text: $usernameGithub)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                }
                Group {
                    Text("URL Github")
                        .font(.caption)
                    TextField("ex: https://github.com/MuhammadHafidz", text: $urlGithub)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .keyboardType(.URL)
                }
                Group {
                    Text("Username Linkedin")
                        .font(.caption)
                    TextField("ex: mhafidzam", text: $usernameLinkd)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                }
                Group {
                    Text("URL Linkedin")
                        .font(.caption)
                    TextField("ex: https://www.linkedin.com/in/mhaff", text: $urlLinkd)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .keyboardType(.URL)
                }
            }
            .padding([.top, .leading, .trailing], 20.0)
        }
        .navigationBarTitle("Edit Profile", displayMode: .inline)
        .toolbar {
            Button {
                ProfileModel.name = self.nama
                ProfileModel.email = self.email
                ProfileModel.image = self.imageUrl
                ProfileModel.usernameIg = self.usernameIg
                ProfileModel.urlIg = self.urlIg
                ProfileModel.usernameGithub = self.usernameGithub
                ProfileModel.urlGithub = self.urlGithub
                ProfileModel.usernameLinkd = self.usernameLinkd
                ProfileModel.urlLinkd = self.urlLinkd
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
            }
        }
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

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
