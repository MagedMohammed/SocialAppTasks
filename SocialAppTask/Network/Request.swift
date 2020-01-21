//
//  Request.swift
//  NovationApp
//
//  Created by Youxel MacBook 8 on 11/6/19.
//  Copyright © 2019 Youxel. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class Request{
    
    
    static func getData<T:Mappable>(routerCase:URLRequestConvertible, completionHandler: @escaping(_ object: T?, _ error:Error?) -> Void){
        Alamofire.request(routerCase).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                guard let data = value as? [String:Any] else{return}
                print(data)
                let dataMapper = Mapper<T>().map(JSON: data)
                completionHandler((dataMapper!),nil)
            case .failure(let error):
                guard let status_code = response.response?.statusCode else{return}
                switch status_code{
                case 401:
//                    ConfigurApp.unAuthorized()
                    print("unAuthorized")
                case 500...599:
                    print("Server Error")
                default:
                    break
                }
                completionHandler(nil,error)
                print(error.localizedDescription)
            }
        }
    }
    
    static func getData<T:Mappable>(url:String,method:HTTPMethod,parameters:[String:Any]?,encoding:ParameterEncoding,headers: HTTPHeaders?,completionHandler: @escaping(_ object: T?, _ error:Error?) -> Void){
        
        guard let url = URL(string: url) else{return}
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                print(value)
                guard let data = value as? [String:Any] else{return}
                let dataMapper = Mapper<T>().map(JSON: data)
                completionHandler(dataMapper,nil)
            case .failure(let error):
                completionHandler(nil,error)
                print(error.localizedDescription)
            }
        }
    }
}



