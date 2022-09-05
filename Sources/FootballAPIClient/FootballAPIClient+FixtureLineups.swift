//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 22/08/22.
//

import Foundation
import NIOCore

extension FootballAPIClient {
    public func fixtureLineups() -> FixtureLineups {
        return FixtureLineups(request: apiRequest)
    }
    
    public class FixtureLineups: Module {
        typealias T = Response<[Model.Fixtures.LineupsInfo]>
        
        private let request: Request
        private var queryParms = [QueryParam: String]()
        
        public func id(_ id: String) -> Self {
            self.queryParms[.id] = id
            return self
        }
        
        public init(request: Request) {
            self.request = request
        }
        
        public func getAsync() async throws -> FootballAPIClient.Response<[Model.Fixtures.LineupsInfo]> {
            try await self.request.getAsync(path: .fixtureLineups, queryParams: queryParms)
        }
        
        public func get() -> EventLoopFuture<FootballAPIClient.Response<[Model.Fixtures.LineupsInfo]>> {
            self.request.get(path: .fixtureLineups, queryParams: queryParms)
        }
        
        
    }
}
