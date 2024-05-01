//
//  NetworkService.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import Foundation
import Alamofire

class NetworkService {
    
    static var shared = NetworkService()
    
    func request<T: Codable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        decadable: T.Type,
        success: @escaping (T) -> (),
        failure: @escaping (AFError) -> ()) {
            
            AF.request(path, method: method, parameters: parameters)
                .validate(statusCode: 200...300)
                .response { response in
                    
                    switch response.result {
                    case .success(let data):
                        
                        do {
                            
                            guard let data = data else { return }
                            let decoder = JSONDecoder()
                            let parseData = try decoder.decode(decadable, from: data)
                            success(parseData)
                            
                        } catch let error {
                            
                            let afError = AFError.sessionTaskFailed(error: error)
                            failure(afError)
                        }
                        
                        
                    case .failure(let error):
                        
                        failure(error)
                    }
                    
                }
        }

}

