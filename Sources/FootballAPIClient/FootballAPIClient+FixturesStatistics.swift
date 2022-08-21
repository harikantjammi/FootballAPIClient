//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 21/08/22.
//

import Foundation
import NIOCore

public extension FootballAPIClient {
    class FixtureStatistics: Module {
        typealias T = Response<Model.Fixtures.StatisticsInfo>
        
        private let request: Request
        private var queryParams = [QueryParam : String]()
        
        init(request: Request) {
            self.request = request
        }
        
        public func fixture(_ id: String) -> Self {
            self.queryParams[.fixture] = id
            return self
        }
        
        public func getAsync() async throws -> Response<Model.Fixtures.StatisticsInfo> {
            try await request.getAsync(path: .fixturesHeadToHead,
                                   queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<Response<Model.Fixtures.StatisticsInfo>> {
            request.get(path: .fixturesHeadToHead,
                        queryParams: queryParams)
        }
    }
}
