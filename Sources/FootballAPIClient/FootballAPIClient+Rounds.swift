//
//  FootballAPIClient+Rounds.swift
//  
//
//  Created by Jammi, Harikant on 16/08/22.
//

import Foundation
import NIOCore
import AsyncHTTPClient


public extension FootballAPIClient {
    
    func fixtureRounds() -> FixtureRounds {
        return FixtureRounds(request: self.apiRequest)
    }
    
    class FixtureRounds: Module {
        typealias T = Response<[String]>
        private var queryParams = [QueryParam : String]()
        private let request: Request
        
        required init(request: Request) {
            self.request = request
        }
        
        public func league(_ id: String) -> Self {
            queryParams[.league] = id
            return self
        }
        
        public func season(_ id: String) -> Self {
            queryParams[.season] = id
            return self
        }
        
        public func current(_ isCurrent: Bool) -> Self {
            queryParams[.current] = isCurrent ? "true" : nil
            return self
        }
                
        
        public func getAsync() async throws -> FootballAPIClient.Response<[String]> {
            try await request.getAsync(path: .fixtureRounds,
                                             queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<FootballAPIClient.Response<[String]>> {
            request.get(path: .fixtures,
                        queryParams: queryParams)
        }
    }
    
    

}
