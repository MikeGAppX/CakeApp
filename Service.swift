//
//  Service.swift
//  CakeApp
//
//  Created by Mikael Galliot on 08/10/2021.
//

import Foundation

typealias Completion<T:Decodable> =  ((Result<[T], ServiceError>) -> Void)

protocol Service:JsonDecodable {
    func fetchData<T:Codable>(client:ServiceClient, type:T.Type, completionHandler:@escaping Completion<T>)
}
