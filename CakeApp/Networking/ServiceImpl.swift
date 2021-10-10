//
//  ServiceImpl.swift
//  CakeApp
//
//  Created by Mikael Galliot on 10/10/2021.
//

import Foundation

class ServiceImpl: Service {
    
    let urlSesson = URLSession(configuration: .default)
    var dataTask:URLSessionDataTask?
    func fetchData<T:Codable>(client:ServiceClient, type:T.Type, completionHandler:@escaping Completion<T>) {
        dataTask?.cancel()
        guard let request = URLRequest.getRequest(client: client) else {
            completionHandler(.failure(.requestNotCreated(message:Constants.requestNotCreated)))
            return
        }
        dataTask =  urlSesson.dataTask(with:request) { [weak self] (data, responce, error)  in
            guard  let _responce = responce as? HTTPURLResponse , _responce.statusCode == 200 else {
                completionHandler(.failure(.errorWith(message: Constants.noResponse)))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.errorWith(message: Constants.noData)))
                return
            }
            // Parsing data using JsonDecoder
            if let result = self?.decode(input:data, type:type) {
                completionHandler(.success(result))
            }else {
                completionHandler(.failure(.parsinFailed(message:Constants.parsingFailed)))
            }
        }
        dataTask?.resume()
    }
}
