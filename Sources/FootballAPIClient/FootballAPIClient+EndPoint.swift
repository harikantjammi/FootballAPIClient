//
//  FootballAPIClient+EndPoint.swift
//  
//
//  Created by Jammi, Harikant on 15/08/22.
//


extension FootballAPIClient {
    
    enum Endpoint: String {
        case leagues
        case seasons = "leagues/seasons"
        case teams
        case teamStatistics = "teams/statistics"
        case teamSeasons = "teams/seasons"
        case venues
        case standings
        case fixtureRounds = "fixtures/rounds"
        case fixtures
        case fixturesHeadToHead = "fixtures/headtohead"
        case fixtureStatistics = "fixtures/statistics"
        case fixtureEvents = "fixtures/events"
        case fixtureLineups = "fixtures/lineups"
        case fixturePlayerStatistics = "fixtures/players"
        case predictions
        case playerStatistics = "players"
        case topScorers = "players/topscorers"
        case topAssists = "players/topassists"
        case topYellowCards = "players/topyellowcards"
        case topRedCards = "players/topredcards"
        case transfers = "transfers"
    }
    
    enum QueryParam: String {
        case id
        case name
        case league
        case season
        case country
        case code
        case venue
        case search
        case team
        case date
        case city
        case current
        case ids
        case live
        case round
        case status
        case h2h
        case fixture
        case from
        case to
        case next
        case timezone
    }
    
    
}
