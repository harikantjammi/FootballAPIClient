import AsyncHTTPClient
import Foundation
import NIO

public enum FootballAPIError: Error {
    case malformedURL
    case badResponse
    case emptyBody
    case invalidJSONResponse
}

public class FootballAPIClient {
    let apiRequest: Request
    
    public init(apiKey: String) {
        self.apiRequest = Request(apiKey: apiKey)
    }
}




