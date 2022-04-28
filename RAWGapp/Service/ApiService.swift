//
//  ApiService.swift
//  RAWGapp
//
//  Created by Enygma System on 13/04/22.
//

import Foundation

func getGames(success: @escaping(GameResponse) -> Void, error: @escaping(String) -> Void) {
    var urlComponent = URLComponents(string: "\(mainUrl)games")

    urlComponent?.queryItems = [
        URLQueryItem(name: "key", value: apiKeys)
    ]
    var urlRequest = URLRequest(url: (urlComponent?.url)!)
    urlRequest.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: urlRequest) { data, _, err in
        if err == nil {
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(GameResponse.self, from: data)
                    success(result)
                }
            } catch let jsonError {
                print("JSON ERROR = \(jsonError.localizedDescription)")
                error(jsonError.localizedDescription.description)
            }
        } else {
            print("Error \(err.debugDescription)")
            error(err.debugDescription)
        }
    }

    task.resume()
}

func getSearchGame(strQuery: String, success: @escaping(GameResponse) -> Void, error: @escaping(String) -> Void) {
    var urlComponent = URLComponents(string: "\(mainUrl)games")

    urlComponent?.queryItems = [
        URLQueryItem(name: "search", value: strQuery),
        URLQueryItem(name: "key", value: apiKeys)
    ]
    var urlRequest = URLRequest(url: (urlComponent?.url)!)
    urlRequest.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: urlRequest) { data, _, err in
        if err != nil {
            print("Error \(err.debugDescription)")
            error(err.debugDescription)
        } else {
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(GameResponse.self, from: data)
                    success(result)
                }
            } catch let jsonError {
                print("JSON ERROR = \(jsonError.localizedDescription)")
                error(jsonError.localizedDescription.description)
            }
        }
    }
    task.resume()
}

func getDetailGame(id: String, success : @escaping(GameDetailModel) -> Void, error : @escaping(String) -> Void) {
    var urlComponent = URLComponents(string: "\(mainUrl)games/\(id)")

    urlComponent?.queryItems = [
        URLQueryItem(name: "key", value: apiKeys)
    ]

    var urlRequest = URLRequest(url: (urlComponent?.url)!)
    urlRequest.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: urlRequest) {data, _, err in
        if err != nil {
            print("Error \(err.debugDescription)")
            error(err.debugDescription)
        } else {
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(GameDetailModel.self, from: data)
                    success(result)
                }
            } catch let jsonError {
                print("JSON ERROR = \(jsonError.localizedDescription)")
                error(jsonError.localizedDescription.description)
            }
        }
    }
    task.resume()
}
