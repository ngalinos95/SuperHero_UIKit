//
//  HeroesService.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos, Vodafone on 28/6/23.
//

import Foundation
import PromiseKit
// We create a protocol to conform in order to use a seperate mock service for our testing purposes
protocol HeroesServiceProtocol {
    func getSuperHero(id: String) -> Promise<SuperHero>
}

protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> HeroeDatask
}
class HeroesService: HeroesServiceProtocol {
    private let session: URLSessionProtocol
    private let urlGiven: String
    init(session: URLSessionProtocol = URLSessionWrapper(),
         urlGiven: String = "https://www.superheroapi.com/api.php/6240691359382436/") {
        self.session = session
        self.urlGiven = urlGiven
    }
    func getSuperHero(id: String) -> Promise<SuperHero> {
        return Promise { seal in
            guard let url = URL(string: urlGiven+id) else {
                return seal.reject(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            }
            let request = URLRequest(url: url)
            session.dataTask(with: request) { data, _, error in
                if let error = error {
                    seal.reject(error)
                } else if let data = data {
                    do {
                        let superhero = try JSONDecoder().decode(SuperHero.self, from: data)
                        seal.fulfill(superhero)
                    } catch {
                        seal.reject(error)
                    }
                }
            }.resume()
        }
    }
}
