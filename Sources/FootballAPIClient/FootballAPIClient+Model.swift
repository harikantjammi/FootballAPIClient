//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 19/08/22.
//

import Foundation

extension FootballAPIClient {
    
    struct Response<T: Codable>: Codable {
        let get: String
        let parameters: [String: String]
        let response: T
        //let errors: Error
        let results: Int?
        
        struct Error : Codable{
            let code: String
        }
        
        struct Paging: Codable {
            let current: Int
            let total: Int
        }
    }
    
    enum Model {
        struct Country: Codable {
            let name: String
            let code: String
            let flag: String
        }
        struct LeagueInfo: Codable {
            let league: League
            let country: Country
            let seasons: [Season]
            
            struct League: Codable {
                let id: Int
                let type: String
                let name: String
                let logo: String
            }
            
            struct Season: Codable {
                let year: Int
                let start: String
                let end: String
                let current: Bool
                let coverage: Coverage
                
                struct Coverage: Codable {
                    let standings: Bool
                    let players: Bool
                    let top_scorers: Bool
                    let top_assists: Bool
                    let top_cards: Bool
                    let injuries: Bool
                    let predictions: Bool
                    let odds: Bool
                }
            }
        }
        struct TeamInfo: Codable {
            let team: Team
            let venue: Venue
            
            struct Team: Codable {
                let id: Int
                let name: String
                let code: String
                let country: String
                let founded: Int
                let national: Bool
                let logo: String
            }
            
            struct Venue: Codable {
                let id: Int
                let name: String
                let address: String
                let city: String
                let capacity: Int
                let surface: String
                let image: String
            }
        }
        struct TeamStatistics: Codable {
            let league: League
            let team: Team
            let form: String
            let fixtures: Fixtures
            let goals: Goals
            let biggest: Biggest
            let clean_sheet: CleanSheet
            let failed_to_score: FailedToScore
            let penalty: Penalty
            let lineups: [Lineup]
            //let cards: Cards
            
            struct Biggest: Codable {
                let streak: Streak
                let wins: Wins
                let loses: Loses
                let goals: Goals
                
                struct Streak: Codable {
                    let wins: Int
                    let draws: Int
                    let loses: Int
                }
                
                struct Wins: Codable {
                    let home: String?
                    let away: String?
                    
                }
                
                struct Loses: Codable {
                    let home: String?
                    let away: String?
                    
                }
                
                struct Goals: Codable {
                    let `for`: Stats
                    let against: Stats
                    
                    struct Stats :Codable {
                        let home: Int
                        let away: Int
                    }
                }
            }
            struct League: Codable {
                let id: Int
                let name: String
                let country: String
                let logo: String
                let flag: String
                let season: Int
            }
            struct CleanSheet: Codable {
                let home: Int
                let away: Int
                let total: Int
            }
            struct FailedToScore: Codable {
                let home: Int
                let away: Int
                let total: Int
            }
            struct Team: Codable {
                let id: Int
                let name: String
                let logo: String
            }
            
            struct Fixtures: Codable {
                struct Stats: Codable {
                    let home: Int
                    let away: Int
                    let total: Int
                }
                let played: Stats
                let wins: Stats
                let draws: Stats
                let loses: Stats
            }
            
            struct Goals: Codable {
                
                let `for`: Statistics
                let against: Statistics
                
                struct Statistics: Codable {
                    let total: Total
                    let average: Average
                    
                    struct Total: Codable {
                        let home: Int
                        let away: Int
                        let total: Int
                    }
                    
                    struct Average: Codable {
                        let home: String
                        let away: String
                        let total: String
                    }
                }
                    
                    
            }
            
            struct Lineup: Codable {
                let formation: String
                let played: Int
            }
            
            struct Penalty: Codable {
                struct Stats: Codable {
                    let total: Int
                    let percentage: String
                }
                let scored: Stats
                let missed: Stats
                let total: Int
            }
            
            
        }
        struct Venue: Codable {
            let id: Int
            let name: String
            let address: String
            let city: String
            let country: String
            let capactity: Int
            let surface: String
            let image: String
        }
        struct StandingsInfo: Codable {
            let league: LeagueInfo
            struct League: Codable {
                let id: Int
                let name: String
                let country: String
                let logo: String
                let flag: String
                let season: Int
                let standings: [[Standings]]
                
                struct Standings: Codable {
                    let rank: Int
                    let team: Team
                    
                    struct Team: Codable {
                        let id: Int
                        let name: String
                        let logo: String
                    }
                    
                    let points: Int
                    let goalsDiff: Int
                    let group: String
                    let form: String
                    let status: String
                    let description: String
                    let all: Statistics
                    let home: Statistics?
                    let away: TeamStatistics?
                    
                    struct Statistics: Codable {
                        let played: Int
                        let win: Int
                        let draw: Int
                        let lose: Int
                        let goals: Goals
                        
                        struct Goals: Codable {
                            let `for`: Int
                            let against: Int
                        }
                    }
                    
                    let updated: String
                    
                    
                }
                
            }
        }
        
        enum Fixtures {
            
            struct Info: Codable {
                let fixture: Fixture
                struct Fixture: Codable {
                    let id: Int
                    let referee: String?
                    let timezone: String
                    let date: String
                    let timestamp: Int
                    
                    let periods: Period
                    
                    struct Period: Codable {
                        let first: String?
                        let second: String?
                    }
                    
                    let venue: Venue
                    struct Venue: Codable {
                        let id: Int?
                        let name: String
                        let city: String
                    }
                    
                    let status: Status
                    struct Status: Codable {
                        let long: String
                        let short: String
                        let elapsed: Int?
                    }
                }
                
                let league: League
                struct League: Codable {
                    let id: Int
                    let name: String
                    let country: String?
                    let logo: String?
                    let flag: String?
                    let season: Int
                    let round: String
                }
                
                let teams: Teams
                struct Teams: Codable {
                    let home: Info
                    let away: Info
                    
                    struct Info: Codable {
                        let id: String
                        let name: String
                        let logo: String
                        let winner: Bool?
                    }
                }
                
                let goals: Goals
                struct Goals: Codable {
                    let home: Int?
                    let away: Int?
                }
                let score: Score
                struct Score: Codable {
                    struct Details: Codable {
                        let home: Int?
                        let away: Int?
                    }
                    let halftime: Details?
                    let fullTime: Details?
                    let extratime: Details?
                    let penalty: Details?
                }
            }
            struct StatisticsInfo: Codable {
                let team: Team
                struct Team: Codable {
                    let id: String
                    let name: String
                    let logo: String
                }
                let statistics: [Statistics]
                struct Statistics: Codable {
                    let type: String
                    let value: String?
                    
                    enum Codingkeys: String, CodingKey  {
                        case type
                        case value
                    }
                    
                    init(from decoder: Decoder) throws {
                        let values = try decoder.container(keyedBy: Codingkeys.self)
                        self.type = try values.decode(String.self, forKey: .type)
                        if let intValue = try? values.decode(Int.self, forKey: .value) {
                            self.value = String(intValue)
                        } else if let stringValue = try? values.decode(String.self, forKey: .value) {
                            self.value = stringValue
                        } else {
                            self.value = nil
                        }
                    }
                }
            }
            struct EventsInfo: Codable {
                let type: String
                let detail: String
                let comments: String?
                
                let time: Time
                struct Time: Codable {
                    let elapsed: Int
                    let extra: Int?
                }
                
                let team: Team
                struct Team: Codable {
                    let id: Int
                    let name: String
                    let logo: String
                }
                
                let player: Player
                struct Player: Codable {
                    let id: Int
                    let name: String
                }
                
                let assist: Assist?
                struct Assist: Codable {
                    let id: String?
                    let name: String?
                }
            }
            struct LineupsInfo: Codable {
                let team: Team
                struct Team: Codable {
                    let id: Int
                    let name: String
                    let logo: String
                    
                    let colors: Colors
                    struct Colors: Codable {
                        let player: ColorInfo
                        let goalkeeper: ColorInfo
                        
                        struct ColorInfo: Codable {
                            let primary: String
                            let number: String
                            let border: String
                        }
                    }
                    let coach: Coach
                    struct Coach: Codable {
                        let id: Int
                        let name: String
                        let photo: String
                    }
                    let formation: String
                    let starXI: [Player]
                    let substitutes: [Player]
                    
                    struct Player: Codable {
                        let id: Int
                        let name: String
                        let number: Int
                        let pos: String
                        let grid: String?
                    }
                }
            }
            
            struct PlayersInfo: Codable {
                let team: Team
                struct Team: Codable {
                    let id: String
                    let logo: String
                    let name: String
                    let update: String
                }
                let players: [PlayerInfo]
                
                struct PlayerInfo: Codable {
                    let player: Player
                    let statistics: Statistics
                    
                    struct Player: Codable {
                        let id: Int
                        let name: String
                        let photo: String
                    }
                    
                    struct Statistics: Codable {
                        let games: Games
                        struct Games: Codable {
                            let minutes: Int?
                            let number: Int?
                            let position: String?
                            let rating: String?
                            let captain: Bool?
                            let substitude: Bool?
                        }
                        let offsides: Int?
                        
                        let shots: Shots
                        struct Shots: Codable {
                            let total: String?
                            let on: String?
                        }
                        
                        let goals: Goals
                        struct Goals: Codable {
                            let total: Int?
                            let conceded: Int?
                            let assists: Int?
                            let saves: Int?
                        }
                        
                        let passes: Passes
                        struct Passes: Codable {
                            let total: Int?
                            let key: Int?
                            let accuracy: String?
                        }
                        
                        let tackles: Tackles
                        struct Tackles: Codable {
                            let total: Int?
                            let blocks: Int?
                            let interceptions: Int?
                        }
                        
                        let duels: Duels
                        struct Duels: Codable {
                            let total: Int?
                            let won: Int?
                        }
                        
                        let dribbles: Dribbles
                        struct Dribbles: Codable {
                            let attempts: Int?
                            let success: Int?
                            let past: Int?
                        }
                        
                        let fouls: Fouls
                        struct Fouls: Codable {
                            let drawn: Int?
                            let committed: Int?
                        }
                        
                        let cards: Cards
                        struct Cards: Codable {
                            let yellow: Int?
                            let red: Int?
                        }
                        let penalty: Penalty
                        struct Penalty: Codable {
                            let won: Int?
                            let committed: Int?
                            let scored: Int?
                            let missed: Int?
                            let saved: Int?
                        }
                        
                    }
                }
                
                
            }
            
        }
        
    }
}

