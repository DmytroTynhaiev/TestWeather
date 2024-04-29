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
    
    func request(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        success: @escaping SuccessTask,
        failure: @escaping FailureTask) {
            
            AF.request(path, method: method, parameters: parameters)
                .validate(statusCode: 200...300)
                .response { response in
                    
                    switch response.result {
                    case .success(let data):
                        let JSON = self.handlerSuccess(data)
                        success(JSON)
                        
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
            let json = try JSONSerialization.jsonObject(with: data) as? [String : Any]
            return json
        } catch {
            print("Seralization error")
            return nil
        }
    }
    
    private func handlerFailure(_ error: AFError) -> AFError {
        return error
    }
}

