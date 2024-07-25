//
//  NetworkError.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
