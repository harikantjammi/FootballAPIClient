//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 20/01/23.
//

import Foundation
import NIO
extension FootballAPIClient {
    
    public func teamSeasons() -> TeamSeasons {
        return TeamSeasons(request: self.apiRequest)
    }
    
    public class TeamSeasons: Module {
        private let request: Request
        private var queryParams: [QueryParam: String] = [:]
        
        public init(request: Request) {
            self.request = request
        }
        
        public func teamId(_ id: String) -> Self {
            self.queryParams[.team] = id
            return self
        }
        
        public func getAsync() async throws -> FootballAPIClient.Response<[Int]>{
            try await self.request.getAsync(path: .teamSeasons, queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<FootballAPIClient.Response<[Int]>> {
            self.request.get(path: .teamSeasons, queryParams: queryParams)
        }
    }
}
