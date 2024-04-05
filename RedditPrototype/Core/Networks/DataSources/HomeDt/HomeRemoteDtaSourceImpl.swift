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
    static let authorization = "bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IlNIQTI1NjpzS3dsMnlsV0VtMjVmcXhwTU40cWY4MXE2OWFFdWFyMnpLMUdhVGxjdWNZIiwidHlwIjoiSldUIn0.eyJzdWIiOiJ1c2VyIiwiZXhwIjoxNzEyMzM4MDkxLjczNDA0MSwiaWF0IjoxNzEyMjUxNjkxLjczNDA0MSwianRpIjoiazF4aHNjeU1pRmhpNmJKTjE0eDZFNXpjTzBHY09nIiwiY2lkIjoiMUdLZXN5bEgzMjNPTWxsd2JWcVJYZyIsImxpZCI6InQyX253eHUzcWlnIiwiYWlkIjoidDJfbnd4dTNxaWciLCJsY2EiOjE2NTQwMjAyMzgwMDAsInNjcCI6ImVKeUtWdEpTaWdVRUFBRF9fd056QVNjIiwiZmxvIjo5fQ.bg7pJEm0QCIQKV4QXidICu8NwrClF8ceKe6hLD8sP7ka4uk-TuYFZxcPCH3LvMXWSPIeepMf_vkvzhDFZ2CSrbdHXV9A6jYOS0g_zspNcyZOw_37W8TxY3dMAoiujEF2y6ZdPqP0rymYBUWU_6vaYf41bf2ZR9vYJJn37YlxmLT3b3gbGJEesuiqw7AVXLPI8ZwxUIT1juLetsR33SeEwkDTl5BZyOVj8EPcUYo2gJnTeBHzrwpOWRtuGkpPN5H7jUlsGkqnydVPwqae9laM-hy9XaFu7HcCHFK6ar0caUurqCsR5Bk36crHv2gtvZjeuA6A_BHaB6TNS-q3T9iJ7g"
    
    static let UserAgent = "sChangeMeClient/0.1 by YourUsername"
}
enum RemoteError: Error {
  case networkError(Error)
  case apiError(Int, Data)
  case decodingError(Error)
}
