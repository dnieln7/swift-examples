//
//  SessionDelegate.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 24/02/25.
//

import SwiftUI

class SessionDelegate: NSObject, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest) async -> URLRequest? {
        debugPrint("url: \(request.url?.absoluteString ?? "No URL")")

        return request
    }
}
