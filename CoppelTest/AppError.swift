//
//  AppError.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import Foundation

enum AppError: Error {
    case loginDenied
    case badIncompleteData
    case badRequest
    case decodingError
    case noData
}
