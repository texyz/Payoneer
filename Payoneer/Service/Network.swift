//
//  Network.swift
//  Payoneer
//
//  Created by Rotimi Joshua on 06/05/2021.
//

import Foundation


public struct UserError: Error {
    let msg: String
}

extension UserError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(msg, comment: "")
    }
}

func checkErrorCode(_ errorCode: Int) -> UserError {
    switch errorCode {
    case 400:
        return UserError(msg: "invalidRequest")
    case 401:
        return UserError(msg: "unAuthorized")
    case 404:
        return UserError(msg: "notFound")
    case 502:
        return UserError(msg: "unAuthorizedClient")
    case 403:
        return UserError(msg: "unAuthorizedClient")
    case 500:
        return UserError(msg: "serverError")
    default:
        return UserError(msg: "Unknown Error")
    }
}


extension Error {
    
    var isConnectivityError: Bool {
        
        let code = (self as NSError).code
        
        if (code == NSURLErrorTimedOut) {
            return true // time-out
        }
        
        if (self._domain != NSURLErrorDomain) {
            return false // Cannot be a NSURLConnection error
        }
        
        switch (code) {
        case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost, NSURLErrorCannotConnectToHost:
            return true
        default:
            return false
        }
    }
    
}

struct Networking{
    static let sharedInstance = Networking()
    let session = URLSession.shared
    
    let PaymentListURL = "https://raw.githubusercontent.com/optile/checkout-android/develop/shared-test/lists/listresult.json"
    
    func getPaymentList(completion: @escaping(Result<PaymentMethodLists,UserError>)->Void) {
        let UserURL=URL(string: PaymentListURL)!
        let dataTask=session.dataTask(with: UserURL){data,urlResponse,error in
            
            guard let jsonData = data else{
                completion(.failure(.init(msg: "NoDataAvailable")))
                return
            }
            
            if let _ = error?.isConnectivityError {
                completion(.failure(.init(msg: "Connection Error")))
                return
            }
            
            guard let urlResp = urlResponse as? HTTPURLResponse, (200...299).contains(urlResp.statusCode) else {
                
                print("Server error!")
                
                if let httpResponse = urlResponse as? HTTPURLResponse {
                    
                    print("error code \(httpResponse.statusCode)")
                    
                    completion(.failure(checkErrorCode(httpResponse.statusCode)))
                    
                    return
                    
                }
                
                return
            }
            
            do{
                let decoder = JSONDecoder()
                //new code ends
                let userResponse = try decoder.decode(PaymentMethodLists.self,from:jsonData)
                print(userResponse)
                completion(.success(userResponse))
            }
            catch{
                completion(.failure(.init(msg: "CannotProcessData")))
            }
        }
        dataTask.resume()
    }
}

