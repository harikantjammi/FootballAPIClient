//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 20/08/22.
//

import Foundation
import AsyncHTTPClient
import NIOCore
import NIOFoundationCompat

public extension FootballAPIClient {
    private static let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
    
    class Request {
        let subscription: Subscription
        
        init(subscription: Subscription) {
            self.subscription = subscription
        }
        
        func getAsync<T: Codable>(path: Endpoint,
                                  queryParams: [QueryParam : String]) async throws -> T {
            guard let request = HTTPClientRequest(path: path,
                                                  queryParams: queryParams,
                                                  subscription: self.subscription) else {
                throw FootballAPIError.malformedURL
            }
            let response = try await httpClient.execute(request, timeout: .seconds(90))
            
            guard response.status == .ok else {
                throw FootballAPIError.badResponse
            }
            
            guard let body = try? await response.body.collect(upTo: 10 * 1024 * 1024) else {
                throw FootballAPIError.emptyBody
            }
            
//           do {
//               let x = try JSONDecoder().decode(T.self, from: body)
//               print(x)
//           } catch {
//               print(error)
//           }
           
            guard let jsonResponse = try? JSONDecoder().decode(T.self, from: body) else {
                throw FootballAPIError.invalidJSONResponse
            }
            return jsonResponse
        }
        
        func get<T: Codable>(path: Endpoint, queryParams: [QueryParam : String]) -> EventLoopFuture<T> {
            guard let request = HTTPClientRequest(path: path,
                                                  queryParams: queryParams,
                                                  subscription: self.subscription) else {
                return httpClient.eventLoopGroup.next().makeFailedFuture(FootballAPIError.malformedURL)
            }
            
            return httpClient
                .execute(url: request.url)
                .flatMapThrowing { response in
                    guard response.status.mayHaveResponseBody else {
                        throw FootballAPIError.emptyBody
                    }
                    return response.body
                }
                .unwrap(orReplace: ByteBuffer())
                .map { try? JSONDecoder().decode(T.self, from: $0) }
                .unwrap(orError: FootballAPIError.invalidJSONResponse)
        }
    }
}

extension HTTPClientRequest {
    
    init?(path: FootballAPIClient.Endpoint,
          queryParams: [FootballAPIClient.QueryParam : String],
          subscription: FootballAPIClient.Subscription) {
        var urlComponents = URLComponents()
        let connectionInfo = subscription.connectionInfo
        urlComponents.scheme = "https"
        urlComponents.host = connectionInfo.host
        urlComponents.path = connectionInfo.pathPrefix + path.rawValue
        urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.rawValue, value: $1) }
        
        guard let urlString = urlComponents.url?.absoluteString else {
            return nil
        }
        
        self.init(url: urlString)
        connectionInfo.headers.forEach {
            self.headers.add(name: $0.0, value: $0.1)
        }
    }
}

extension FootballAPIClient.Subscription {
    
    struct ConnectionConfiguration {
        let host: String
        let headers: [(String, String)]
        let pathPrefix: String
    }
    
    var connectionInfo: ConnectionConfiguration {
        switch self {
        case .rapidAPI(apiKey: let apiKey):
            return ConnectionConfiguration(host: "api-football-v1.p.rapidapi.com",
                                          headers: [("X-RapidAPI-Key", apiKey),
                                                    ("X-RapidAPI-Host", "api-football-v1.p.rapidapi.com")],
                                          pathPrefix: "/v3/")
        case .footballAPI(apiKey: let apiKey):
            return ConnectionConfiguration(host: "v3.football.api-sports.io",
                                          headers: [("x-apisports-key", apiKey)],
                                          pathPrefix: "/")
        }
    }
}
