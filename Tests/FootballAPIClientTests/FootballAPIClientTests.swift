import XCTest
import FootballAPIClient

final class FootballAPIClientTests: XCTestCase {
    let subscription = FootballAPIClient.Subscription.footballAPI(apiKey: "<football-api-key-here>")
    func testFixtureRounds() async throws {
        let client = FootballAPIClient(subscription: subscription)
        do {
            let response = try await client.fixtureRounds()
                                            .league("39")
                                            .season("2022")
                                            .getAsync()
            print(response)
        } catch {
            print(error)
        }
    }
    
    func testCurrentFixtureRounds() async throws {
        let client = FootballAPIClient(subscription: subscription)
        do {
            let response = try await client.fixtureRounds()
                                            .season("2022")
                                            .league("39")
                                            .current(true).getAsync()
            print(response)
        } catch {
            print(error)
        }
    }
    
    func testFixture() async throws {
        do {
            let client = try await FootballAPIClient(subscription: subscription)
                                                    .fixtures()
                                                    .season("2022")
                                                    .round("Regular Season - 6")
                                                    .league("39").getAsync()
            print(client)
        } catch {
            print(error)
        }
    }
    
    func testFixtureForSingleMatch() async throws {
        do {
            let client = try await FootballAPIClient(subscription: subscription)
                                                    .fixtures()
                                                    .id("867946").getAsync()
            print(client)
        } catch {
            print(error)
        }
    }
    
    func testHeadtoHeadFixture() async throws {
        do {
            let client = try await FootballAPIClient(subscription: subscription)
                                                    .headToHead()
                                                    .h2h("33-34")
                                                    .league("39")
                                                    .season("2022")
                                                    .getAsync()
            print(client)
        } catch {
            print(error)
        }
    }
    
    func testFixtureStatistics() async throws {
        do {
            let client = try await FootballAPIClient(subscription: subscription)
                                                    .fixtureStatistics()
                                                    .fixture("867946")
                                                    .getAsync()
            print(client)
        } catch {
            print(error)
        }
    }
    
    func testPlayerStats() async throws {
        do {
            let client = try await FootballAPIClient(subscription: subscription)
                                    .player()
                                    .endPointType(.info)
                                    .id("18835")
                                    .league("39")
                                    .season("2022")
                                    .getAsync()
            print(client)
        } catch {
            print(error)
        }
    }
    
    func testTopScorers() async throws {
        do {
            let client = try await FootballAPIClient(subscription: subscription)
                                        .player()
                                        .endPointType(.topScorers)
                                        .season("2022").league("39").getAsync()
            print(client)            
        } catch {
            print(error)
        }
    }
    
    func testStandings() async throws {
        do {
            let client = try await FootballAPIClient(subscription: subscription)
                                    .standings()
                                    .league("39")
                                    .season("2022").getAsync()
            print(client)
        } catch {
            print(error)
        }
    }
    
    func testPlayers() async throws {
        do {
            let client = try await FootballAPIClient(subscription: subscription)
                .teams().id("33").getAsync()
            print(client)
            
        } catch {
            print(error)
        }
    }
    
    func testFixturesForDate() async throws {
        do {
            print("fetching fixtures \(Date())")
            let client = try await FootballAPIClient(subscription: subscription)
                .fixtures().date("2022-09-18").getAsync()
            print("fetching fixtures end \(Date())")
        } catch {
            print(error)
        }
    }
    
    func testPlayerStatistics() async throws {
        do {
            let client = try await FootballAPIClient(subscription: subscription)
                .fixturePlayerStatistics().fixture("867946").getAsync()
            print(client)
        } catch {
            print(error)
        }
    }
    
}
