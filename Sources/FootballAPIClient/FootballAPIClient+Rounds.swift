//
//  FootballAPIClient+Rounds.swift
//  
//
//  Created by Jammi, Harikant on 16/08/22.
//

import Foundation

public extension FootballAPIClient {
    
    struct FixtureRounds: Codable {
        let response: [String]
    }
    
    func getAllRounds(leagueId: String, season: String) async throws -> [String] {
        let data = try await self.executeRequest(path: .fixtureRounds,
                                                 query: [.league: leagueId,
                                                         .season: season])
        do {
            let fixtureRounds = try JSONDecoder().decode(FixtureRounds.self, from: data)
            return fixtureRounds.response
        } catch {
            throw FootballAPIError.invalidJSONResponse
        }
    }
    
    func getCurrentRound(leagueId: String, season: String) async throws -> String? {
        let data = try await self.executeRequest(path: .fixtureRounds,
                                                 query: [.league: leagueId,
                                                         .season: season,
                                                         .current: "true"])
        do {
            let fixtureRounds = try JSONDecoder().decode(FixtureRounds.self, from: data)
            return fixtureRounds.response.first
        } catch {
            throw FootballAPIError.invalidJSONResponse
        }
    }
}
