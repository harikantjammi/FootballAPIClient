//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 21/01/23.
//

import Foundation
import NIO

extension FootballAPIClient {
    
    public func teamStatistics() -> TeamStatistics {
        TeamStatistics(request: self.apiRequest)
    }
    
    public class TeamStatistics: Module {
        
        let request: Request
        private var queryParams: [QueryParam: String] = [:]
        
        public init(request: Request) {
            self.request = request
        }
        
        public func teamId(_ teamId: String) -> Self {
            self.queryParams[.team] = teamId
            return self
        }
        
        public func league(_ leagueId: String) -> Self {
            self.queryParams[.league] = leagueId
            return self
        }
        
        public func season(_ seasonId: String) -> Self {
            self.queryParams[.season] = seasonId
            return self
        }
        
        public func getAsync() async throws -> Response<FootballAPIClient.Model.TeamStatistics> {
            try await request.getAsync(path: .teamStatistics, queryParams: queryParams)
        }
        
        public func get() -> EventLoopFuture<Response<FootballAPIClient.Model.TeamStatistics>> {
            request.get(path: .teamStatistics, queryParams: queryParams)
        }
    }
    
}

extension FootballAPIClient.Model {
    public struct TeamStatistics: Codable {
        public let league: League
        public let team: Team
        public let form: String?
        public let fixtures: Fixtures
        public let goals: Goals
        public let biggest: Biggest
        public let clean_sheet: CleanSheet
        public let failed_to_score: FailedToScore
        public let penalty: Penalty
        public let lineups: [Lineup]
        public let cards: Cards
        
        public struct Cards: Codable {
            public let yellow: Statistics?
            public let red: Statistics?
            
            public struct Statistics: Codable {
                public let zeroToFifteen: Value?
                public let sixteenToThirty: Value?
                public let thirtyOneToFortyFive: Value?
                public let fortySixToSixty: Value?
                public let sixtyOneToSeventyFive: Value?
                public let seventySixToNinety: Value?
                public let ninetyOneTo105: Value?
                public let oneHundredSixToOneHunderdTwenty: Value?
                
                enum CodingKeys: String, CodingKey {
                    case zeroToFifteen = "0-15"
                    case sixteenToThirty = "16-30"
                    case thirtyOneToFortyFive = "31-45"
                    case fortySixToSixty = "46-60"
                    case sixtyOneToSeventyFive = "61-75"
                    case seventySixToNinety = "76-90"
                    case ninetyOneTo105 = "91-105"
                    case oneHundredSixToOneHunderdTwenty = "106-120"
                }
                
                public struct Value: Codable {
                    public let total: Int?
                }
            }
        }

        public struct Biggest: Codable {
            public let streak: Streak
            public let wins: Wins
            public let loses: Loses
            public let goals: Goals
            
            public struct Streak: Codable {
                public let wins: Int
                public let draws: Int
                public let loses: Int
            }
            
            public struct Wins: Codable {
                public let home: String?
                public let away: String?
                
            }
            
            public struct Loses: Codable {
                public let home: String?
                public let away: String?
            }
            
            public struct Goals: Codable {
                public let `for`: Stats
                public let against: Stats
                
                public struct Stats: Codable {
                    public let home: Int
                    public let away: Int
                }
            }
            
        }
        public struct League: Codable {
            public let id: Int
            public let name: String
            public let country: String
            public let logo: String
            public let flag: String
            public let season: Int
        }
        public struct CleanSheet: Codable {
            public let home: Int
            public let away: Int
            public let total: Int
        }
        public struct FailedToScore: Codable {
            public let home: Int
            public let away: Int
            public let total: Int
        }
        public struct Team: Codable {
            public let id: Int
            public let name: String
            public let logo: String
        }
        
        public struct Fixtures: Codable {
            public struct Stats: Codable {
                public let home: Int
                public let away: Int
                public let total: Int
            }
            public let played: Stats
            public let wins: Stats
            public let draws: Stats
            public let loses: Stats
        }
        
        public struct Goals: Codable {
            
            public let `for`: Statistics
            public let against: Statistics
            
            public struct Statistics: Codable {
                public let total: Total
                public let average: Average
                
                public struct Total: Codable {
                    public let home: Int
                    public let away: Int
                    public let total: Int
                }
                
                public struct Average: Codable {
                    public let home: String
                    public let away: String
                    public let total: String
                }
            }
        }
        
        public struct Lineup: Codable {
            public let formation: String
            public let played: Int
        }
        
        public struct Penalty: Codable {
            public struct Stats: Codable {
                public let total: Int
                public let percentage: String
            }
            public let scored: Stats
            public let missed: Stats
            public let total: Int
        }
        
    }
}
