//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 22/08/22.
//

import Foundation
import NIOCore

extension FootballAPIClient {
    
    public func fixtureEvents() -> FixtureEvents {
        return FixtureEvents(apiRequest: self.apiRequest)
    }
    
    public class FixtureEvents: Module {
        private var queryParams = [QueryParam : String]()
        
        public func fixture(_ id: String) -> Self {
            queryParams[.fixture] = id
            return self
        }
        
        public func team(_ id: String) -> Self {
            queryParams[.team] = id
            return self
        }
        
        public func type(_ id: String) -> Self {
            queryParams[.type] = id
            return self
        }
        
        typealias T = Response<[Model.Fixtures.EventsInfo]>
        private let request: Request
        
        public init(apiRequest: Request) {
            self.request = apiRequest
        }
        
        public func getAsync() async throws -> Response<[Model.Fixtures.EventsInfo]> {
            try await self.request.getAsync(path: .fixtureEvents,
                                            queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<Response<[Model.Fixtures.EventsInfo]>> {
            self.request.get(path: .fixtureEvents,
                             queryParams: queryParams)
        }
        
        
    }
}
