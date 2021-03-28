//
//  Api.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import Foundation

class Api {
    private let domain = "https://api.punkapi.com/"
    private let version = "v2/"
    private let session = URLSession(configuration: .default)
}

// MARK: - Request
extension Api {
    
    func request<Success: Decodable>(
        path: String, method: HTTPMethod, parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil, completion: @escaping (Result<Success, Error>) -> Void
    ) {
        let request = createRequest(path: path, method: method, parameters: parameters, headers: headers)
        session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            let nsError: NSError?
            if let error = error {
                nsError = error as NSError
            } else {
                nsError = nil
            }
            self.checkResult(data: data, response: response, error: nsError, completion: completion)
        }.resume()
    }
}

// MARK: - Request. Private
private extension Api {
    
    func checkResult<Success: Decodable>(
        if let data = data {
            #if DEBUG
            #warning("todo")
//            print("URL ", response?.url ?? "")
//            let string = String(data: data, encoding: .utf8) ?? "Data isn't convertable to String"
//            print(string)
            #endif
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(Success.self, from: data)
                completion(.success(result))
                return
            } catch {
                decodingError = error as? DecodingError
                #if DEBUG
                print(error)
                #endif
                do {
                    let error = try decoder.decode(Error.self, from: data)
                    completion(.failure(error))
                    return
                } catch {
                    if decodingError == nil {
                        decodingError = error as? DecodingError
                    }
                    #if DEBUG
                    print(error)
                    #endif
                }
            }
        }
        
        if let code = statusCode, (code < 200 || code > 299) {
            let description = "Unknown error. \(code)"
            let error = Error(statusCode: code, description: description)
            completion(.failure(error))
        } else {
            var code = statusCode
            if code == nil, let error = error {
                code = error.code
            }
            var description = "Unknown error"
            if let error = decodingError {
                description += ".\n" + error.localizedDescription
            }
            let error = Error(statusCode: code, description: description)
            completion(.failure(error))
        }
    }
    
    func createRequest(path: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders?) -> URLRequest {
        var components = URLComponents(string: domain + version + path)!
        
        // GET parameters
        switch method {
        case .get:
            if let parameters = parameters {
                var queryItems = [URLQueryItem]()
                parameters.forEach {
                    queryItems.append(URLQueryItem(name: $0, value: String(describing: $1)))
                }
                components.queryItems = queryItems
                components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            }
        default:
            break
        }
        
        // Request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue.uppercased()
        
        // Parameters
        switch method {
        case .get:
            break
        default:
            if let parameters = parameters {
                request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // Headers
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        return request
    }
}

// MARK: - Model
extension Api {
    enum HTTPMethod: String {
        case get, post, put, patch, delete
    }
    
    typealias HTTPHeaders = [String: String]
    
    struct Error: Decodable {
        let code: String?
        let statusCode: Int?
        private let message: String
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            code = try container.decode(String.self, forKey: .code)
            statusCode = nil
            message = try container.decode(String.self, forKey: .message)
        }
        
        init(statusCode: Int?, description: String) {
            code = nil
            self.statusCode = statusCode
            self.message = description
        }
        
        var isNetworkConnetionError: Bool {
            guard let code = statusCode else { return false }
            return [
                URLError.Code.networkConnectionLost, .notConnectedToInternet,.timedOut
            ].contains(URLError.Code(rawValue: code))
        }
        
        var description: String {
            isNetworkConnetionError ? "Oops... it looks like\nsomething with the internet :(" : message
        }
        
        enum CodingKeys: String, CodingKey {
            case message, code = "statusCode"
        }
    }
}
