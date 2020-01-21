//
//  RouterLayer.swift
//  SocialAppTask
//
//  Created by Youxel mac5 on 1/20/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://jsonplaceholder.typicode.com/"
    
    case Comments(Int)
    case posts
    case create([String: Any])
    case edit([String: Any])
    case delete(Int)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .Comments,.posts:
                return .get
            case .create:
                return .post
            case .delete:
                return .delete
            case .edit:
                return .patch
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .Comments, .delete, .posts:
                return nil
            case .create(let newPost):
                return (newPost)
            case .edit(let editPost):
                return editPost
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case .Comments(let id):
                relativePath = "comments?postId=\(id)"
            case .create:
                relativePath = "posts"
            case .delete(let id):
                relativePath = "/posts/\(id)"
            case .posts:
                relativePath = "posts/"
            case .edit(_):
                relativePath = "posts"
            }
            
            var url = URL(string: Router.baseURLString)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        print(url)
        return try encoding.encode(urlRequest, with: params)
    }
}
