//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 22/08/22.
//

import Foundation
import NIOCore

public extension FootballAPIClient {
    
    func player() -> Player {
        Player(request: self.apiRequest)
    }
    
    public class Player: Module {

        typealias T = Response<[Model.PlayerStatisticsInfo]>
        private let request: Request
        private var endPointType: EndpointType = .info
        private var queryParams: [QueryParam : String] = [:]
        
        public init(request: Request) {
            self.request = request
        }
        
        public func endPointType(_ id: EndpointType) -> Self {
            self.endPointType = id
            return self
        }
        
        public func league(_ id: String) -> Self {
            self.queryParams[.league] = id
            return self
        }
        
        public func season(_ id: String) -> Self {
            self.queryParams[.season] = id
            return self
        }
        
        public func id(_ id: String) -> Self {
            self.queryParams[.id] = id
            return self
        }
        
        public func teamId(_ teamId: String) -> Self {
            self.queryParams[.team] = teamId
            return self
        }
        
        public func page(_ page: Int) -> Self {
            queryParams[.page] = String(page)
            return self
        }
        
        public func search(_ id: String) -> Self {
            self.queryParams[.search] = id
            return self
        }
        
        public enum EndpointType {
            case info
            case topScorers
            case topAssists
            case topYellowCards
            case topRedCards
        }
        
        private var endPoint: Endpoint {
            switch endPointType {
            case .info:
                return .playerStatistics
            case .topScorers:
                return .topScorers
            case .topAssists:
                return .topAssists
            case .topYellowCards:
                return .topYellowCards
            case .topRedCards:
                return .topRedCards
            }
        }
        
        public func getAsync() async throws -> FootballAPIClient.Response<[FootballAPIClient.Model.PlayerStatisticsInfo]> {
            try await self.request.getAsync(path: endPoint, queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<FootballAPIClient.Response<[FootballAPIClient.Model.PlayerStatisticsInfo]>> {
            self.request.get(path: endPoint, queryParams: queryParams)
        }
        
        
    }
}
