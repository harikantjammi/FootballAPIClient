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
        
        public func id(_ id: String) -> Self {
            queryParams[.id] = id
            return self
        }
        
        public func name(_ id: String) -> Self {
            queryParams[.name] = id
            return self
        }
        
        public func code(_ code: String) -> Self {
            queryParams[.code] = code
            return self
        }
        
        public func search(_ search: String) -> Self {
            queryParams[.search] = search
            return self
        }
        
        public func country(_ country: String) -> Self {
            queryParams[.country] = country
            return self
        }
        
        public func league(_ league: String) -> Self {
            queryParams[.league] = league
            return self
        }
        
        public func season(_ season: String) -> Self {
            queryParams[.season] = season
            return self
        }
        
        
        public func getAsync() async throws -> FootballAPIClient.Response<[FootballAPIClient.Model.TeamInfo]> {
            try await request.getAsync(path: .teams, queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<FootballAPIClient.Response<[FootballAPIClient.Model.TeamInfo]>> {
            request.get(path: .teams, queryParams: queryParams)
        }
        
        
        
        
        
    }
    
}
