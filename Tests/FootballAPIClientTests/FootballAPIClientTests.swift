import XCTest
import FootballAPIClient

final class FootballAPIClientTests: XCTestCase {
    let apiKey = "api-key-here"
    func testFixtureRounds() async throws {
        let client = FootballAPIClient(apiKey: apiKey)
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
        let client = FootballAPIClient(apiKey: apiKey)
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
            let client = try await FootballAPIClient(apiKey: self.apiKey)
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
            let client = try await FootballAPIClient(apiKey: self.apiKey)
                                                    .fixtures()
                                                    .id("867946").getAsync()
            print(client)
        } catch {
            print(error)
        }
    }
    
    func testHeadtoHeadFixture() async throws {
        do {
            let client = try await FootballAPIClient(apiKey: self.apiKey)
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
            let client = try await FootballAPIClient(apiKey: self.apiKey)
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
            let client = try await FootballAPIClient(apiKey: self.apiKey)
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
            let client = try await FootballAPIClient(apiKey: self.apiKey)
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
            let client = try await FootballAPIClient(apiKey: self.apiKey)
                                    .standings()
                                    .league("39")
                                    .season("2022").getAsync()
            print(client)
        } catch {
            print(error)
        }
    }
    
}
