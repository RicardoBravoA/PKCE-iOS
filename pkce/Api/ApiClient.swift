//
//  ApiClient.swift
//  pkce
//
//  Created by Ricardo Bravo on 19/03/22.
//

import Foundation

class ApiClient {
    
    class func movie(completion: @escaping ([MovieResponseItem]?, Error?) -> Void) {
        taskForGETRequest(url: EndPoint.movie.url, response: MovieResponse.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func transaction(request: TransactionRequest, completion: @escaping (TransactionResponse?, Error?) -> Void) {
        taskForPOSTRequest(url: EndPoint.transaction.url, body: request, response: TransactionResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    private class func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        let code = self.encode(path: url.path, verb: "get", body: "{}")
        print(code)
        request.httpMethod = "GET"
        request.setValue(code, forHTTPHeaderField: "request-id")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    private class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, body: RequestType, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse as Error)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    private class func encode(path: String, verb: String, body: String) -> String {
        print("\(path)\(verb)\(body)")
        return ("\(path)\(verb)\(body)".data(using: .utf8)?.base64EncodedString())!
    }
    
}
