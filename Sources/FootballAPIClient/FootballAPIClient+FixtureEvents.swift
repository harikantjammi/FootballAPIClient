//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 22/08/22.
//

import Foundation
import NIOCore

extension FootballAPIClient {
    
    func fixtureEvents() -> FixtureEvents {
        return FixtureEvents(apiRequest: self.apiRequest)
    }
    
    class FixtureEvents: Module {
        private var queryParams = [QueryParam : String]()
        
        func fixture(_ id: String) -> Self {
            queryParams[.fixture] = id
            return self
        }
        
        func team(_ id: String) -> Self {
            queryParams[.team] = id
            return self
        }
        
        func type(_ id: String) -> Self {
            queryParams[.type] = id
            return self
        }
        
        typealias T = Response<[Model.Fixtures.EventsInfo]>
        private let request: Request
        
        init(apiRequest: Request) {
            self.request = apiRequest
        }
        
        func getAsync() async throws -> Response<[Model.Fixtures.EventsInfo]> {
            try await self.request.getAsync(path: .fixtureEvents,
                                            queryParams: queryParams)
        }
        
        func get() -> EventLoopFuture<Response<[Model.Fixtures.EventsInfo]>> {
            self.request.get(path: .fixtureEvents,
                             queryParams: queryParams)
        }
        
        
    }
}
