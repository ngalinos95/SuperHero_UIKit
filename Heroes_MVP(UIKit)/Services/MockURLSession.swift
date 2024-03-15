//
//  URLSessionMock.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos,   on 12/7/23.
//

import Foundation
protocol HeroeDatask {
    func resume ()
}

class MockURLSession: URLSessionProtocol {
    var responseData: Data?
    var responseError: Error?
    var lastRequest: URLRequest?
    var mockDatask: MockDataTask = .init()
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> HeroeDatask {
        lastRequest = request
        // Simulate asynchronous behavior by invoking the completion handler on the next run loop cycle
        DispatchQueue.main.async {
            completionHandler(self.responseData, nil, self.responseError)
        }
        return mockDatask
    }
}
extension URLSessionDataTask: HeroeDatask {
}
class MockDataTask: HeroeDatask {
    func resume() {
        self.resumeCalled =  true
    }
    var resumeCalled = false
}
