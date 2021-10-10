//
//  URLRequest+Extension.swift
//  CakeApp
//
//  Created by Mikael Galliot on 10/10/2021.
//

import Foundation

extension URLRequest {
    static func getRequest(client:ServiceClient) ->URLRequest? {
        guard var urlComponents = URLComponents(string:client.baseUrl + client.path) else {
            return nil
        }
        urlComponents.query = "\(client.params)"
        guard let url = urlComponents.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = client.method
        return urlRequest
    }
}
