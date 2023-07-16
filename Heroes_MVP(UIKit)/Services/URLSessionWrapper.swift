//
//  URLSessionWrapper.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos, Vodafone on 12/7/23.
//

import Foundation

class URLSessionWrapper: URLSessionProtocol {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> HeroeDatask {
        return session.dataTask(with: request, completionHandler: completionHandler)
    }
}
