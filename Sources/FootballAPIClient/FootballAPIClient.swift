import AsyncHTTPClient
import Foundation
import NIO

enum FootballAPIError: Error {
    case malformedURL
    case badResponse
    case emptyBody
    case invalidJSONResponse
}

public class FootballAPIClient {
    private let apiKey: String
    private static let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func executeRequest(path: FootballAPIClient.Endpoint,
                        query: [FootballAPIClient.QueryParam : String]) async throws -> Data {
        
        
        guard let request = HTTPClientRequest(path: path,
                                              queryParams: query,
                                              apiKey: self.apiKey) else {
            throw FootballAPIError.malformedURL
        }
        
        let response = try await Self.httpClient.execute(request, timeout: .seconds(10))
        guard response.status == .ok else {
            throw FootballAPIError.badResponse
        }
        
        do {
            let body = try await response.body.collect(upTo: 10 * 1024 * 1024)
            return Data(buffer: body)
        } catch {
            throw FootballAPIError.emptyBody
        }
    }
    
    func executeRequest(path: FootballAPIClient.Endpoint,
                        query: [FootballAPIClient.QueryParam : String]) -> EventLoopFuture<Data> {
        guard let request = HTTPClientRequest(path: path,
                                              queryParams: query,
                                              apiKey: self.apiKey) else {
            return Self.httpClient.eventLoopGroup.next().makeFailedFuture(FootballAPIError.malformedURL)
        }
        
        return Self.httpClient
            .execute(url: request.url)
            .flatMapThrowing { response in
                guard response.status.mayHaveResponseBody else {
                    throw FootballAPIError.emptyBody
                }
                return response.body
            }
            .unwrap(orReplace: ByteBuffer())
            .map { Data.init(buffer: $0) }
    }
    
}

extension HTTPClientRequest {
    init?(path: FootballAPIClient.Endpoint,
          queryParams: [FootballAPIClient.QueryParam : String], apiKey: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "v3.football.api-sports.io"
        urlComponents.path = "/" + path.rawValue
        urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.rawValue, value: $1) }
        
        guard let urlString = urlComponents.url?.absoluteString else {
            return nil
        }
        
        self.init(url: urlString)
        self.headers.add(name: "x-apisports-key", value: apiKey)
    }
}


