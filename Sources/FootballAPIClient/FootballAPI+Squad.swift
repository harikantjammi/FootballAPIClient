//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 16/01/23.
//

import Foundation
import NIO
extension FootballAPIClient {
    
    public func squad() -> TeamSquad {
        return TeamSquad(request: self.apiRequest)
    }
    
    public class TeamSquad: Module {
        
        private let request: Request
        private var queryParams = [QueryParam : String]()
        
        public init(request: Request) {
            self.request = request
        }
        
        public func teamId(_ id: String) -> Self {
            queryParams[.team] = id
            return self
        }
        
        public func getAsync() async throws -> FootballAPIClient.Response<[FootballAPIClient.Model.TeamSquadResponse]> {
            try await request.getAsync(path: .squads, queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<FootballAPIClient.Response<[FootballAPIClient.Model.TeamSquadResponse]>> {
            request.get(path: .squads, queryParams: queryParams)
        }
        
        typealias T = Response<[FootballAPIClient.Model.TeamSquadResponse]>
        
        
        
    }
}

public extension FootballAPIClient.Model {
    public struct TeamSquadResponse: Codable {
        public let team: Team
        
        public struct Team: Codable {
            public let id: Int
            public let name: String
            public let logo: String?
        }
        
        public let players: [Player]
        
        public struct Player: Codable {
            public let id: Int
            public let name: String
            public let age: Int?
            public let number: Int?
            public let position: String?
            public let photo: String?
        }
    }
}
