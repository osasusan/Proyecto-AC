//
//  NetworkError.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/5/24.
//

import Foundation


class NetworkError{
    
    enum networkErrorEnum : Error{
        case invalidUrl
        case invalidResponse
        case invalidData
        case requestFailed
        case authenticationError
        case badRequest
        case outdated
        case failed
        case unknown
        case validationError(String)
        
        
        var customLocalizedDescription: String {
            return switch self {
                case .invalidUrl:
                    "The URL is not valid"
                case .invalidResponse:
                    "The response received from the server is not valid"
                case .invalidData:
                    "The data received from the server is not valid"
                case .requestFailed:
                    "The request failed"
                case .authenticationError:
                    "There was an authentication error"
                case .badRequest:
                    "The request is not valid"
                case .outdated:
                    "The request is outdated"
                case .failed:
                    "The request failed for an unknown reason"
                case .unknown:
                    "An unknown error occurred"
                case .validationError(let messageErrors):
                    messageErrors
            }
        }
    }
}

