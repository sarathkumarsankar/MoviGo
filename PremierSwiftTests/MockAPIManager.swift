
import Foundation
@testable import PremierSwift


class MockAPIManager: APIManaging {
    var mockResult: Result<Any, APIError>?
    
    func execute<Value>(_ request: PremierSwift.Request<Value>, completion: @escaping (Result<Value, PremierSwift.APIError>) -> Void) where Value : Decodable {
        if let mockResult = mockResult as? Result<Value, APIError>  {
            completion(mockResult)
        } else {
            completion(.failure(APIError.networkError))
        }
    }
}
