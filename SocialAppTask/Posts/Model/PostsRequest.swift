//
//  PostsRequest.swift
//  SocialAppTask
//
//  Created by Youxel mac5 on 1/20/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import Foundation
import Alamofire


class PostsRequest{
    
    static func getPosts(completionHandler: @escaping(_ posts: [Posts]?, _ error:Error?) -> Void){
        var postsData = [Posts]()
        Alamofire.request(Router.posts).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                print(value)
                guard let data = value as? [[String:Any]] else{return}
                for post in data{
                    let dataMapper = Posts(JSON: post) ?? Posts()
                    postsData.append(dataMapper)
                }
                completionHandler(postsData,nil)
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
}
