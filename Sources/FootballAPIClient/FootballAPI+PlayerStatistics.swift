//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 06/10/22.
//

import Foundation
import NIOCore

extension FootballAPIClient {
    
    public func fixturePlayerStatistics() -> FixturePlayerStatistics {
        FixturePlayerStatistics(request: self.apiRequest)
    }
    
    public class FixturePlayerStatistics: Module {
        
        typealias T = Response<[FootballAPIClient.Model.Fixtures.PlayersInfo]>
        private let request: Request
        private var queryParams = [QueryParam : String]()
        
        public init(request: Request) {
            self.request = request
        }
        
        public func fixture(_ id: String) -> Self {
            self.queryParams[.fixture] = id
            return self
        }

        public func getAsync() async throws -> Response<[FootballAPIClient.Model.Fixtures.PlayersInfo]> {
            try await self.request.getAsync(path: .fixturePlayerStatistics,
                                            queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<Response<[FootballAPIClient.Model.Fixtures.PlayersInfo]>> {
            self.request.get(path: .fixturePlayerStatistics,
                             queryParams: queryParams)
        }
    }
}
