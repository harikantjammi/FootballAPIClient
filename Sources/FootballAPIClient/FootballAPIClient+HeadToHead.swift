//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 21/08/22.
//

import Foundation
import NIOCore
public extension FootballAPIClient {
    
    public func headToHead() -> HeadToHead {
        HeadToHead(request: self.apiRequest)
    }
    
    public class HeadToHead: Module {
        
        private let request: Request
        typealias T = Response<[Model.Fixtures.Info]>
        private var queryParams = [QueryParam : String]()
        
        public required init(request: Request) {
            self.request = request
        }
        
        public func h2h(_ value: String) -> Self {
            self.queryParams[.h2h] = value
            return self
        }
        
        public func league(_ league: String) -> Self {
            self.queryParams[.league] = league
            return self
        }
        
        public func season(_ season: String) -> Self {
            self.queryParams[.season] = season
            return self
        }
        
        public func getAsync() async throws -> FootballAPIClient.Response<[Model.Fixtures.Info]> {
            try await self.request.getAsync(path: .fixturesHeadToHead,
                                            queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<FootballAPIClient.Response<[Model.Fixtures.Info]>> {
            return self.request.get(path: .fixturesHeadToHead, queryParams: queryParams)
        }
        
    }
}
