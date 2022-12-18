//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 18/12/22.
//

import Foundation
import NIO

extension FootballAPIClient {
    
    public func leagues() -> Leagues {
        Leagues(request: self.apiRequest)
    }
    
    public class Leagues: Module {
        
        let request: FootballAPIClient.Request
        private var queryParams = [QueryParam : String]()
        
        public init(request: Request) {
            self.request = request
        }
        
        public func id(_ id: String) -> Self {
            queryParams[.id] = id
            return self
        }
        
        public func name(_ name: String) -> Self {
            queryParams[.name] = name
            return self
        }
        
        public func code(_ code: String) -> Self {
            queryParams[.code] = code
            return self
        }
        
        public func search(_ searchTerm: String) -> Self {
            queryParams[.search] = searchTerm
            return self
        }
        
        public func country(_ country: String) -> Self {
            queryParams[.country] = country
            return self
        }
        
        public func season(_ season: String) -> Self {
            queryParams[.season] = season
            return self
        }
        
        public func current(_ current: String) -> Self {
            queryParams[.current] = current
            return self
        }
        
        public func team(_ id: String) -> Self {
            queryParams[.team] = id
            return self
        }
        
        public func getAsync() async throws -> FootballAPIClient.Response<[FootballAPIClient.Model.LeagueInfo]> {
            try await self.request.getAsync(path: .leagues, queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<FootballAPIClient.Response<[FootballAPIClient.Model.LeagueInfo]>> {
            self.request.get(path: .leagues, queryParams: queryParams)
        }
        
        
    }
}
