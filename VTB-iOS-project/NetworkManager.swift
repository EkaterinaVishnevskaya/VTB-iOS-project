//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Екатерина Вишневская - ВТБ on 07.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    static let networkManager = NetworkManager();
    
    enum HTTPMethod {
        static let put = "PUT"
        static let get = "GET"
        static let  patch = "POST"
    }
    
    enum NetworkErrors: Error {
        case commonNetworkError
    }
    
    func requestGet (urlString: String, completion: @escaping (Result<Data?, NetworkErrors>) -> Void) {
       guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            if let data = data {completion(.success(data))
                } else {
                    completion(.failure(.commonNetworkError))
                    return
            }
        })
        
        task.resume()
    }
    
    func requestPut (urlString: String, body: Data?, completion: @escaping (Result<Data?, NetworkErrors>) -> Void) {
        let session = URLSession.shared
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put
        request.httpBody = body
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Client error!")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
        
            if let data = data {completion(.success(data))
                }   else {
                completion(.failure(.commonNetworkError))
                return
        }
        }
        
        task.resume()
    }
    
    func requestPost (urlString: String, completion: @escaping (Result<Data?, NetworkErrors>) -> Void) {
       guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            if let data = data {completion(.success(data))
                } else {
                    completion(.failure(.commonNetworkError))
                    return
            }
        })
        
        task.resume()
    }
    
}

