//
//  PostsListPresenter.swift
//  SocialAppTask
//
//  Created by Youxel mac5 on 1/20/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import Foundation

protocol PostsListPresenterProtocol: class {
    func getPostsData()
    func deletePost(id:Int)
}
class PostsListPresenter: PostsListPresenterProtocol {
    
//    MARK:- Properties
    var view: PostListViewProtocol!
    
//    MARK:- Init
    init(view:PostListViewProtocol){
        self.view = view
    }
//    MARK:- Method
    func getPostsData() {
        PostsRequest.getPosts { [weak self](data, error) in
            guard let self = self else{return}
            if let data = data, error == nil{
                self.view.setPost(data: data)
            }else{
                if let error = error{
                    self.view.showAlert(title: "Error", message: error.localizedDescription )
                }
            }
        }
//        Request.getData(routerCase: Router.posts) { ( data:[Posts]?, error) in
//            if let data = data, error == nil{
//                print(data)
//            }
//        }
    }
    
    
    func deletePost(id:Int) {
        Request.getData(routerCase: Router.delete(id)) { (data:Posts?, error) in
            if let data = data, error == nil{
                self.view.showAlert(title: "Success", message: "Message")
            }
        }
    }
}
