//
//  HomeDtRemoteDataSourceImpl.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import Combine
import Alamofire
import Factory

class HomeRemoteDtaSourceImpl : HomeRemoteDtaSource {
    func accessToken() -> AnyPublisher<Token, RemoteError> {
        let url = "https://www.reddit.com/api/v1/access_token"

        let parameters: [String: String] = [
            "grant_type": "password",
            "username": "Electronic-Box-6147",
            "password": "AlanisReddit2025*"
        ]

        let credentialData = "\(APIHome.username):\(APIHome.password)".data(using: .utf8)
        let base64Credentials = credentialData?.base64EncodedString() ?? ""

        let headers: HTTPHeaders = [
            "Authorization": "Basic \(base64Credentials)"
        ]

        return AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
               .publishData()
               .tryMap { dataResponse -> Data in
                   guard let statusCode = dataResponse.response?.statusCode else {
                       throw RemoteError.networkError(NSError(domain: "Invalid response", code: 0, userInfo: nil))
                   }

                   if 200..<300 ~= statusCode {
                       return dataResponse.data ?? Data()
                   } else if statusCode == 401 {
                       throw RemoteError.apiError(statusCode, Data())
                   } else {
                       throw RemoteError.apiError(statusCode, dataResponse.data ?? Data())
                   }
               }
               .decode(type: Token.self, decoder: JSONDecoder())
               .mapError { error -> RemoteError in
                   if let apiError = error as? RemoteError {
                       return apiError
                   } else {
                       return RemoteError.decodingError(error)
                   }
               }
               .eraseToAnyPublisher()
       }
    
    func redditTop(query: String) -> AnyPublisher<RedditResponse, RemoteError> {
        let headers: HTTPHeaders = [
            "Authorization": "bearer " +  Helper.getUserToken() ,"User-Agent":"\(APIHome.UserAgent)"]
        
        let url = "\(RPSettings.current.baseUrl)\(query)/top"
        
        return AF.request(url, method: .get, headers: headers)
            .publishData()
            .tryMap { dataResponse -> Data in
                guard let statusCode = dataResponse.response?.statusCode else {
                    throw RemoteError.networkError(NSError(domain: "Invalid response", code: 0, userInfo: nil))
                }

                if 200..<300 ~= statusCode {
                    return dataResponse.data ?? Data()
                } else if statusCode == 401 {
                    throw RemoteError.apiError(statusCode, Data())
                } else {
                    throw RemoteError.apiError(statusCode, dataResponse.data ?? Data())
                }
            }
            .decode(type: RedditResponse.self, decoder: JSONDecoder())
            .mapError { error -> RemoteError in
                if let apiError = error as? RemoteError {
                    return apiError
                } else {
                    return RemoteError.decodingError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

struct APIHome {
    static let username = "1GKesylH323OMllwbVqRXg"
    static let password = "qmaImVZpfXctzlCiJAu8T2vRQG-VaQ"
    static let UserAgent = "sChangeMeClient/0.1 by YourUsername"
}

enum RemoteError: Error {
  case networkError(Error)
  case apiError(Int, Data)
  case decodingError(Error)
}
