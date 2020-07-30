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
        static let  patch = "PATCH"
        static let delete = "DELETE"
    }
    
    func requestGet (urlString: String) -> Data? {
        let url = URL(string: urlString)
        var fileData: Data? = nil
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    fileData = data
                }
            } else
            {
                print ("Data Error")
                return
            }
        })
        
        task.resume()
        
        return fileData
    }
    
    func requestPut (urlString: String, body: Data?) {
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
        }
        
        task.resume()
    }
    
    
    
}

