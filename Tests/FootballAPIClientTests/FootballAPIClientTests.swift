import XCTest
import FootballAPIClient

final class FootballAPIClientTests: XCTestCase {
    let apiKey = "7dfaf54e3a8c3dec0a46fe4bf6b8ff49"
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
    
}
