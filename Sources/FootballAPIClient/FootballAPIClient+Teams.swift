//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 02/09/22.
//

import Foundation
import NIOCore

public extension FootballAPIClient {
    
    func teams() -> Teams {
        Teams(request: self.apiRequest)
    }
    
    class Teams: Module {
        typealias T = Response<[Model.TeamInfo]>
        private let request: Request
        private var queryParams = [QueryParam : String]()
        
        init(request: Request) {
            self.request = request
        }
        
        func id(_ id: String) -> Self {
            queryParams[.id] = id
            return self
        }
        
        func name(_ id: String) -> Self {
            queryParams[.name] = id
            return self
        }
        
        func code(_ code: String) -> Self {
            queryParams[.code] = code
            return self
        }
        
        func search(_ search: String) -> Self {
            queryParams[.search] = search
            return self
        }
        
        func country(_ country: String) -> Self {
            queryParams[.country] = country
            return self
        }
        
        func league(_ league: String) -> Self {
            queryParams[.league] = league
            return self
        }
        
        func season(_ season: String) -> Self {
            queryParams[.season] = season
            return self
        }
        
        
        func getAsync() async throws -> FootballAPIClient.Response<[FootballAPIClient.Model.TeamInfo]> {
            try await request.getAsync(path: .teams, queryParams: queryParams)
        }
        
        func get() -> EventLoopFuture<FootballAPIClient.Response<[FootballAPIClient.Model.TeamInfo]>> {
            request.get(path: .teams, queryParams: queryParams)
        }
        
        
        
        
        
    }
    
}
