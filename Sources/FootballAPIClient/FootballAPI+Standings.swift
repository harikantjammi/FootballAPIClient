//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 05/09/22.
//

import Foundation
import NIOCore

extension FootballAPIClient {
    
    public func standings() -> Standings {
        return Standings(request: self.apiRequest)
    }
    
    public class Standings: Module {
        typealias T = Response<[Model.StandingsInfo]>
        private let request: Request
        private var queryParams = [QueryParam : String]()
        

        
        public init(request: Request) {
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
        
        public func team(_ id: String) -> Self {
            queryParams[.team] = id
            return self
        }
        
        public func getAsync() async throws -> Response<[Model.StandingsInfo]> {
            try await self.request.getAsync(path: .standings, queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<Response<[Model.StandingsInfo]>> {
            self.request.get(path: .standings, queryParams: queryParams)
        }
    }
}
