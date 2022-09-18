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
    
    public init(subscription: Subscription) {
        self.apiRequest = Request(subscription: subscription)
    }
}

extension FootballAPIClient {
    public enum Subscription {
        case rapidAPI(apiKey: String)
        case footballAPI(apiKey: String)
    }
}




