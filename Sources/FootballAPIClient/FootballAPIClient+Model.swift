//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 19/08/22.
//

import Foundation

public extension FootballAPIClient {
    
    struct Response<T: Codable>: Codable {
        public let get: String
        public let parameters: [String: String]
        public let response: T
        //public let errors: Error
        public let results: Int?
        
        public struct Error : Codable{
            public let code: String
        }
        
        public struct Paging: Codable {
            public let current: Int
            public let total: Int
        }
    }
    
    enum Model {
        public struct Country: Codable {
            public let name: String
            public let code: String?
            public let flag: String?
        }
        public struct LeagueInfo: Codable {
            public let league: League
            public let country: Country
            public let seasons: [Season]
            
            public struct League: Codable {
                public let id: Int
                public let type: String
                public let name: String
                public let logo: String
            }
            
            public struct Season: Codable {
                public let year: Int
                public let start: String
                public let end: String
                public let current: Bool
                public let coverage: Coverage
                
                public struct Coverage: Codable {
                    public let standings: Bool
                    public let players: Bool
                    public let top_scorers: Bool
                    public let top_assists: Bool
                    public let top_cards: Bool
                    public let injuries: Bool
                    public let predictions: Bool
                    public let odds: Bool
                }
            }
        }
        public struct TeamInfo: Codable {
            public let team: Team
            public let venue: Venue
            
            public struct Team: Codable {
                public let id: Int?
                public let name: String?
                public let code: String?
                public let country: String?
                public let founded: Int?
                public let national: Bool?
                public let logo: String?
            }
            
            public struct Venue: Codable {
                public let id: Int?
                public let name: String?
                public let address: String?
                public let city: String?
                public let capacity: Int?
                public let surface: String?
                public let image: String?
            }
        }
        public struct Venue: Codable {
            public let id: Int?
            public let name: String?
            public let address: String?
            public let city: String?
            public let country: String?
            public let capactity: Int?
            public let surface: String?
            public let image: String?
        }
        public struct StandingsInfo: Codable {
            public let league: League
            public struct League: Codable {
                public let id: Int?
                public let name: String?
                public let country: String?
                public let logo: String?
                public let flag: String?
                public let season: Int?
                public let standings: [[Standings]]
                
                public struct Standings: Codable {
                    public let rank: Int?
                    public let team: Team?
                    
                    public struct Team: Codable {
                        public let id: Int
                        public let name: String?
                        public let logo: String?
                    }
                    
                    public let points: Int?
                    public let goalsDiff: Int?
                    public let group: String?
                    public let form: String?
                    public let status: String?
                    public let description: String?
                    public let all: Statistics?
                    public let home: Statistics?
                    public let away: Statistics?
                    
                    public struct Statistics: Codable {
                        public let played: Int?
                        public let win: Int?
                        public let draw: Int?
                        public let lose: Int?
                        public let goals: Goals?
                        
                        public struct Goals: Codable {
                            public let `for`: Int?
                            public let against: Int?
                        }
                    }
                    
                    public let updated: String?
                    
                    
                }
                
            }
        }
        

        
        public enum Fixtures {
            public struct Info: Codable {
                public let fixture: Fixture
                public struct Fixture: Codable {
                    public let id: Int
                    public let referee: String?
                    public let timezone: String
                    public let date: String
                    public let timestamp: Int
                    
                    public let periods: Period
                    
                    public struct Period: Codable {
                        public let first: Int?
                        public let second: Int?
                    }
                    
                    public let venue: Venue
                    public struct Venue: Codable {
                        public let id: Int?
                        public let name: String?
                        public let city: String?
                    }
                    
                    public let status: Status
                    public struct Status: Codable {
                        public let long: String
                        public let short: String
                        public let elapsed: Int?
                    }
                }
                
                public let league: League
                public struct League: Codable {
                    public let id: Int
                    public let name: String
                    public let country: String?
                    public let logo: String?
                    public let flag: String?
                    public let season: Int
                    public let round: String
                }
                
                public let teams: Teams
                public struct Teams: Codable {
                    public let home: Info
                    public let away: Info
                    
                    public struct Info: Codable {
                        public let id: Int?
                        public let name: String
                        public let logo: String?
                        public let winner: Bool?
                    }
                }
                
                public let goals: Goals
                public struct Goals: Codable {
                    public let home: Int?
                    public let away: Int?
                }
                public let score: Score
                public struct Score: Codable {
                    public struct Details: Codable {
                        public let home: Int?
                        public let away: Int?
                    }
                    public let halftime: Details?
                    public let fullTime: Details?
                    public let extratime: Details?
                    public let penalty: Details?
                }
            }
            public struct StatisticsInfo: Codable {
                public let team: Team
                public struct Team: Codable {
                    public let id: Int?
                    public let name: String
                    public let logo: String
                }
                public let statistics: [Statistics]
                public struct Statistics: Codable {
                    public let type: String
                    public let value: String?
                    
                    enum Codingkeys: String, CodingKey  {
                        case type
                        case value
                    }
                    
                    public init(from decoder: Decoder) throws {
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
            
            public struct EventsInfo: Codable {
                public let type: String
                public let detail: String
                public let comments: String?
                
                public let time: Time
                public struct Time: Codable {
                    public let elapsed: Int
                    public let extra: Int?
                }
                
                public let team: Team
                public struct Team: Codable {
                    public let id: Int
                    public let name: String
                    public let logo: String
                }
                
                public let player: Player
                public struct Player: Codable {
                    public let id: Int
                    public let name: String
                }
                
                public let assist: Assist?
                public struct Assist: Codable {
                    public let id: Int?
                    public let name: String?
                }
            }
            public struct LineupsInfo: Codable {
                public let team: Team
                public let coach: Coach
                public let formation: String?
                public let startXI: [PlayerInfo]?
                public let substitutes: [PlayerInfo]?
                
                public struct PlayerInfo: Codable {
                    public let player: Player
                    
                    public struct Player: Codable {
                        public let id: Int?
                        public let name: String?
                        public let number: Int?
                        public let pos: String?
                        public let grid: String?
                    }
                }

                
                public struct Coach: Codable {
                    public let id: Int?
                    public let name: String?
                    public let photo: String?
                }
                
                public struct Team: Codable {
                    public let id: Int?
                    public let name: String?
                    public let logo: String?
                    
                    public let colors: Colors
                    public struct Colors: Codable {
                        public let player: ColorInfo?
                        public let goalkeeper: ColorInfo?
                        
                        public struct ColorInfo: Codable {
                            public let primary: String?
                            public let number: String?
                            public let border: String?
                        }
                    }

                }
            }
            
            public struct PlayersInfo: Codable {
                public let team: Team
                public struct Team: Codable {
                    public let id: Int?
                    public let logo: String
                    public let name: String
                    public let update: String
                }
                public let players: [PlayerInfo]
                
                public struct PlayerInfo: Codable {
                    public let player: Player
                    public let statistics: [Statistics]
                    
                    public struct Player: Codable {
                        public let id: Int
                        public let name: String
                        public let photo: String
                    }
                    
                    public struct Statistics: Codable {
                        public let games: Games
                        public struct Games: Codable {
                            public let minutes: Int?
                            public let number: Int?
                            public let position: String?
                            public let rating: String?
                            public let captain: Bool?
                            public let substitude: Bool?
                        }
                        public let offsides: Int?
                        
                        public let shots: Shots
                        public struct Shots: Codable {
                            public let total: Int?
                            public let on: Int?
                        }
                        
                        public let goals: Goals
                        public struct Goals: Codable {
                            public let total: Int?
                            public let conceded: Int?
                            public let assists: Int?
                            public let saves: Int?
                        }
                        
                        public let passes: Passes
                        public struct Passes: Codable {
                            public let total: Int?
                            public let key: Int?
                            public let accuracy: String?
                        }
                        
                        public let tackles: Tackles
                        public struct Tackles: Codable {
                            public let total: Int?
                            public let blocks: Int?
                            public let interceptions: Int?
                        }
                        
                        public let duels: Duels
                        public struct Duels: Codable {
                            public let total: Int?
                            public let won: Int?
                        }
                        
                        public let dribbles: Dribbles
                        public struct Dribbles: Codable {
                            public let attempts: Int?
                            public let success: Int?
                            public let past: Int?
                        }
                        
                        public let fouls: Fouls
                        public struct Fouls: Codable {
                            public let drawn: Int?
                            public let committed: Int?
                        }
                        
                        public let cards: Cards
                        public struct Cards: Codable {
                            public let yellow: Int?
                            public let red: Int?
                        }
                        public let penalty: Penalty
                        public struct Penalty: Codable {
                            public let won: Int?
                            public let committed: Int?
                            public let scored: Int?
                            public let missed: Int?
                            public let saved: Int?
                        }
                    }
                }
            }
        }
        
        public struct PlayerStatisticsInfo: Codable {
            public let player: Player
            
            public struct Player: Codable {
                public let id: Int
                public let name: String
                public let firstname: String?
                public let lastname: String?
                public let age: Int?
                public let birth: Birth?
                public struct Birth: Codable {
                    let date: String?
                    let place: String?
                    let country: String?
                }
            }
            public let statistics: [Statistics]
            
            public struct Statistics: Codable {
                public let team: Team
                public struct Team: Codable {
                    public let id: Int?
                    public let name: String
                    public let logo: String?
                }
                
                public let league: League
                public struct League: Codable {
                    public let id: Int?
                    public let name: String?
                    public let country: String?
                    public let flag: String?
                    public let logo: String?
                    //let season: Int?
                }
                
                public let games: Games
                public struct Games: Codable {
                    public let minutes: Int?
                    public let number: Int?
                    public let position: String?
                    public let rating: String?
                    public let captain: Bool?
                    public let substitude: Bool?
                }
                public let offsides: Int?
                
                public let shots: Shots
                public struct Shots: Codable {
                    public let total: Int?
                    public let on: Int?
                }
                
                public let goals: Goals
                public struct Goals: Codable {
                    public let total: Int?
                    public let conceded: Int?
                    public let assists: Int?
                    public let saves: Int?
                }
                
                public let passes: Passes
                public struct Passes: Codable {
                    public let total: Int?
                    public let key: Int?
                    public let accuracy: Int?
                }
                
                public let tackles: Tackles
                public struct Tackles: Codable {
                    public let total: Int?
                    public let blocks: Int?
                    public let interceptions: Int?
                }
                
                public let duels: Duels
                public struct Duels: Codable {
                    public let total: Int?
                    public let won: Int?
                }
                
                public let dribbles: Dribbles
                public struct Dribbles: Codable {
                    public let attempts: Int?
                    public let success: Int?
                    public let past: Int?
                }
                
                public let fouls: Fouls
                public struct Fouls: Codable {
                    public let drawn: Int?
                    public let committed: Int?
                }
                
                public let cards: Cards
                public struct Cards: Codable {
                    public let yellow: Int?
                    public let red: Int?
                }
                public let penalty: Penalty
                public struct Penalty: Codable {
                    public let won: Int?
                    public let committed: Int?
                    public let scored: Int?
                    public let missed: Int?
                    public let saved: Int?
                }
            }
        }
    }
}

