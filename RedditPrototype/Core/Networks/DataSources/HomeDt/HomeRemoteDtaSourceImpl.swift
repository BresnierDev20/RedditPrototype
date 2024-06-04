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
    //var datastore = Container.datastore
    
    func redditTop(query: String) -> AnyPublisher<RedditResponse, RemoteError> {
        let headers: HTTPHeaders = [
            "Authorization": "\(APIReddit.authorization)","User-Agent":"\(APIReddit.UserAgent)"]
        
        let url = "\(APIReddit.baseUrl)\(query)/top"
        
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

struct APIReddit {
    static let baseUrl = URLDomains.BASE
    static let authorization = "bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IlNIQTI1NjpzS3dsMnlsV0VtMjVmcXhwTU40cWY4MXE2OWFFdWFyMnpLMUdhVGxjdWNZIiwidHlwIjoiSldUIn0.eyJzdWIiOiJ1c2VyIiwiZXhwIjoxNzE3NjAzMTQzLjg3MTU1MywiaWF0IjoxNzE3NTE2NzQzLjg3MTU1MywianRpIjoiWEQ4dGdsLWRWRW5fZHNQMlpoYUYtOF9zeVlWRkZnIiwiY2lkIjoiMUdLZXN5bEgzMjNPTWxsd2JWcVJYZyIsImxpZCI6InQyX253eHUzcWlnIiwiYWlkIjoidDJfbnd4dTNxaWciLCJsY2EiOjE2NTQwMjAyMzgwMDAsInNjcCI6ImVKeUtWdEpTaWdVRUFBRF9fd056QVNjIiwiZmxvIjo5fQ.cbDjNOJkKpmeb_Str873cLeeJHzPHyfi94PbdTMPNuCCtshlug9ZR_yb-QzIfODB0Ril0B1zCG-Y-7glf5AeH378Ky_BR5sPa92OPuWLhLxM43aCV-rr31cKmllIghTTFfH2cJCp2mxVz67IjsiuXH45SmpQUwWDbDHTsXAUSvrpzrrtRl-TUYSOwG4h2ech9fI5A5d4fWLcbQITf_6b7K98t4m8ufjvKt2Zx8qE9aPNVQwUE3-c6WttVDjmajR5m9pf0OWRbO1wDZrZ0RWjuNij-58C-y1tdKWnrq2p3Iy1IXFRT7Ik2hd9-TekN3aQXm52v8IiXhXDf_D3a0dwQA"
    
    static let UserAgent = "sChangeMeClient/0.1 by YourUsername"
}
enum RemoteError: Error {
  case networkError(Error)
  case apiError(Int, Data)
  case decodingError(Error)
}
