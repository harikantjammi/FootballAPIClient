//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 21/08/22.
//

import Foundation
import NIOCore

public extension FootballAPIClient {
    
    func fixtures() -> FixturesModule {
        FixturesModule(request: self.apiRequest)
    }
    
    class FixturesModule: Module {
        private let request: Request
        
        public func getAsync() async throws -> FootballAPIClient.Response<[FootballAPIClient.Model.Fixtures.Info]> {
            try await request.getAsync(path: .fixtures,
                                       queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<Response<[Model.Fixtures.Info]>> {
            request.get(path: .fixtures,
                        queryParams: queryParams)
        }
        
        typealias T = Response<[Model.Fixtures.Info]>
        
        private var queryParams: [QueryParam: String] = [:]
        
        init(request: Request) {
            self.request = request
        }
        
        public func id(_ id: String) -> Self {
            queryParams[.id] = id
            return self
        }
        
        public func ids(_ ids: String) -> Self {
            queryParams[.ids] = ids
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
        
        public func team(_ team: String) -> Self {
            queryParams[.team] = team
            return self
        }
        
        public func live(_ live: String) -> Self {
            queryParams[.live] = live
            return self
        }
        
        public func from(_ from: String) -> Self {
            queryParams[.from] = from
            return self
        }
        
        public func to(_ to: String) -> Self {
            queryParams[.to] = to
            return self
        }
        
        public func last(_ last: String) -> Self {
            queryParams[.last] = last
            return self
        }
        
        public func next(_ next: String) -> Self {
            queryParams[.next] = next
            return self
        }
        
        public func round(_ round: String) -> Self {
            queryParams[.round] = round
            return self
        }
        
        public func status(_ status: String) -> Self {
            queryParams[.status] = status
            return self
        }
        
        public func venue(_ venue: String) -> Self {
            queryParams[.venue] = venue
            return self
        }
        
        public func date(_ date: String) -> Self {
            queryParams[.date] = date
            return self
        }
        
        public func timezone(_ timezone: String) -> Self {
            queryParams[.timezone] = timezone
            return self
        }
    }
}
