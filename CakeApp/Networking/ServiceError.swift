//
//  ServiceError.swift
//  CakeApp
//
//  Created by Mikael Galliot on 08/10/2021.
//

import Foundation


enum ServiceError: Error {
    case parsinFailed(message:String)
    case errorWith(message:String)
    case networkNotAvailalbe
    case requestNotCreated(message:String)
}
