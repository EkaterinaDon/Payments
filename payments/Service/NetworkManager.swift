//
//  NetworkManager.swift
//  payments
//
//  Created by Ekaterina on 2.07.21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    var payments: [Payments] = []
    
    let headers: HTTPHeaders = ["app-key":"12345",
                                "v":"1"]
    
    func login(login: String, password: String, completion: @escaping ((String) -> Void)) {
        
        let baseUrl = URL(string: "http://82.202.204.94/api-test/login")
        let formData = [
            "login": login,
            "password": password
        ]
        
        if let url = baseUrl {
            AF.upload(multipartFormData: { (multiFormData) in
                for (key, value) in formData {
                    multiFormData.append(Data(value.utf8), withName: key)
                }
            }, to: url, method: .post, headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let token = try JSONDecoder().decode(Login.self, from: data).response.token
                        completion(token)
                    } catch let error as NSError {
                        debugPrint(error.localizedDescription)
                    }
                case .failure(let error):
                    debugPrint("fail: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getPayments(token: String?, completion: @escaping (([Payments]) -> Void)) {
        
        let baseUrl = URL(string: "http://82.202.204.94/api-test/payments")
        
        if let token = token, let url = baseUrl {
            let parameters  = ["token":token]
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseJSON { [weak self] responce in
                guard let self = self else { return }
                
                switch responce.result {
                case .success(let json):
                    let itemObject : Dictionary = json as! Dictionary<String,Any>
                    if let array = itemObject["response"] as? [[String : Any]] {
                        
                        for dict in array {
                            if let desc = dict["desc"] as? String, let amount = dict["amount"] as? Double, let currency = dict["currency"] as? String, let created = dict["created"] as? Double {
                                self.payments.append(Payments(amount: amount, created: created, currency: currency, desc: desc))
                            } else if let desc = dict["desc"] as? String, let amount = dict["amount"] as? Double, let created = dict["created"] as? Double {
                                self.payments.append(Payments(amount: amount, created: created, currency: "", desc: desc))
                            } else if let desc = dict["desc"] as? String, let amount = dict["amount"] as? String, let currency = dict["currency"] as? String, let created = dict["created"] as? Double {
                                self.payments.append(Payments(amount: Double(amount)!, created: created, currency: currency, desc: desc))
                            }
                        }
                        completion(self.payments)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }            
        }
    }
}
