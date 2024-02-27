//
//  File.swift
//
//
//  Created by Ahmed Naguib on 27/02/2024.
//

import Foundation
import NetworkingLayer
import SmilesSharedServices
import SmilesUtilities
import SmilesBaseMainRequestManager

enum AboutSmilesRequest {
    case getFaqs(request: FAQsDetailsRequest)
    case getOffers(request: SmilesBaseMainRequest)
    
    private var httpMethod: SmilesHTTPMethod {
        switch self {
        default:
            return .POST
        }
    }
    
    func createRequest(endPoint: AboutSmilesEndpoint) -> NetworkRequest {
        var headers: [String: String] = [:]
        
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["CUSTOM_HEADER"] = "pre_prod"
        
        let endPointUrl = endPoint.url
        let baseUrl = AppCommonMethods.serviceBaseUrl
        let fullUrl = "\(baseUrl)\(endPointUrl)"
        
        return NetworkRequest(url: fullUrl,
                              headers: headers,
                              reqBody: requestBody,
                              httpMethod: httpMethod)
    }
    
    private var requestBody: Encodable? {
        switch self {
        case .getFaqs(let request):
            return request
        case .getOffers(request: let request):
            return request
        }
    }
}
