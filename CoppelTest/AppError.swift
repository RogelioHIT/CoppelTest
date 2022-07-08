//
//  AppError.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import Foundation

enum AppError: Error {
    case wrongURL
    case badRequest
    case decodingError
    case noData
    case badHTTPBodySerialization
}
