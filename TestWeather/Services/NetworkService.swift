//
//  NetworkService.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import Foundation
import Alamofire

//"https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m"

class NetworkService {
    
    typealias SuccessTask = ([String: Any]?) -> ()
    typealias FailureTask = (AFError) -> ()
     
    static var shared = NetworkService()
    
    func request<T: Codable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        decadable: T.Type,
        success: @escaping (T) -> (),
        failure: @escaping FailureTask) {
            
            AF.request(path, method: method, parameters: parameters)
                .validate(statusCode: 200...300)
                .response { response in
                    
                    switch response.result {
                    case .success(let data):
//                        let JSON = self.handlerSuccess(data)
//                        success(JSON)
                        
                        do {
                            
                            guard let data = data else { return }
                            let decoder = JSONDecoder()
                            let parseData = try decoder.decode(decadable, from: data)
                            success(parseData)
                            
                        } catch {
                            print("Error")
                        }
                        
                        
                    case .failure(let error):
                        let configuredError = self.handlerFailure(error)
                        failure(configuredError)
                    }
                    
                }
        }
    
    // MARK: - Task handlers
    
    private func handlerSuccess(_ data: Data?) -> [String: Any]? {
        do {
            guard let data = data else { return nil }
            let json = try JSONSerialization.jsonObject(with: data)
            
            switch json.self {
            case is [String: Any]: return json as? [String : Any]
            case is [[String: Any]]: return ["array" : json]
            default: return nil
            }
        
        } catch {
            print("Seralization error")
            return nil
        }
    }
    
    private func handlerFailure(_ error: AFError) -> AFError {
        return error
    }
}

