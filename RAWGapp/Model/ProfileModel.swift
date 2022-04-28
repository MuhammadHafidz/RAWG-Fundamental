//
//  ProfileModel.swift
//  RAWGapp
//
//  Created by Enygma System on 15/04/22.
//

import Foundation

struct ProfileModel {
    static let nameKey = "name"
    static let imageKey = "image"
    static let emailKey = "email"
    static let usernameIgKey = "usernameIg"
    static let usernameGithubKey = "usernameGithub"
    static let usernameLinkdKey = "usernameLinkd"
    static let urlIgKey = "urlIg"
    static let urlGithubKey = "urlGithub"
    static let urlLinkdKey = "urlLinkd"

    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? "M. Hafidz Amarul M."
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }

    static var image: String {
        get {
            return UserDefaults.standard.string(forKey: imageKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: imageKey)
        }
    }

    static var email: String {
        get {
            return UserDefaults.standard.string(forKey: emailKey) ?? "h_vdz@live.com"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }

    static var usernameIg: String {
        get {
            return UserDefaults.standard.string(forKey: usernameIgKey) ?? "mhafidzam"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: usernameIgKey)
        }
    }

    static var usernameGithub: String {
        get {
            return UserDefaults.standard.string(forKey: usernameGithubKey) ?? "MuhammadHafidz"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: usernameGithubKey)
        }
    }

    static var usernameLinkd: String {
        get {
            return UserDefaults.standard.string(forKey: usernameLinkdKey) ?? "M Hafidz AM"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: usernameLinkdKey)
        }
    }

    static var urlIg: String {
        get {
            return UserDefaults.standard.string(forKey: urlIgKey) ?? "https://www.instagram.com/mhafidzam/"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: urlIgKey)
        }
    }

    static var urlGithub: String {
        get {
            return UserDefaults.standard.string(forKey: urlGithubKey) ?? "https://github.com/MuhammadHafidz"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: urlGithubKey)
        }
    }

    static var urlLinkd: String {
        get {
            return UserDefaults.standard.string(forKey: urlLinkdKey) ?? "https://www.linkedin.com/in/mhaff"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: urlLinkdKey)
        }
    }

    static func synchronize() {
        UserDefaults.standard.synchronize()
    }

}
