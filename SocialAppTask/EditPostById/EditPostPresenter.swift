//
//  EditPostPresenter.swift
//  SocialAppTask
//
//  Created by Youxel mac5 on 1/21/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import Foundation

protocol  EditPostPresenterProtocol{
    func addPost(title:String, userId:Int, body:String)
    func editPost(title:String, userId:Int, body:String)
}

class EditPostPresenter : EditPostPresenterProtocol {
    var view : EditPostViewProtocol!
    
    init(view:EditPostViewProtocol){
        self.view = view
    }
    
    func addPost(title: String, userId: Int, body: String) {
        
        let parameters = [
            "userId": userId,
            "title": title,
            "body": body
            ] as [String : Any]
        
        Request.getData(routerCase: Router.edit(parameters)) { (data:Posts?, error) in
            if let data = data, error == nil {
                self.view.showAlert(title: "Add Successed", message: "Your post \(title) add successfully")
                self.view.updateDone(data: data)
            }
        }
    }
    
    func editPost(title: String, userId: Int, body: String) {
        let parameters = [
            "userId": userId,
            "title": title,
            "body": body
            ] as [String : Any]
        
        Request.getData(routerCase: Router.edit(parameters)) { (data:Posts?, error) in
            if let data = data, error == nil {
                self.view.showAlert(title: "Add Successed", message: "Your post \(title) add successfully")
                self.view.updateDone(data: data)
            }
        }
    }
    
    
  
    
    
    
    
}

