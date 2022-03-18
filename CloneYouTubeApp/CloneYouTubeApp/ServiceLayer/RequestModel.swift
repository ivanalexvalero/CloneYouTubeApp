//
//  RequestModel.swift
//  CloneYouTubeApp
//
//  Created by Ivan Valero on 18/03/2022.
//

import Foundation


struct RequestModel {
    let endpoint: Endpoints
    var queryItems: [String:String]?
    let httpMethod: HttpMethod = .GET
    var baseUrl: URLBase = .youtube
    
    func getURL() -> String {
        return baseUrl.rawValue + endpoint.rawValue
    }
    
    enum HttpMethod: String {
        case GET
        case POST
    }
    
    enum Endpoints: String {
        case search = "/search"
        case empty = ""
    }
    
    enum URLBase: String {
        case youtube = "https://www.googleapis.com/youtube/v3"
        case google = "https://otherweb.com/v2"
    }
    
}

