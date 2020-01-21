//
//  EditPostViewController.swift
//  SocialAppTask
//
//  Created by Youxel mac5 on 1/20/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import UIKit


protocol  EditPostViewProtocol : ShowAlertProtocol {
    func updateDone(data:Posts)
}

class EditPostViewController: UIViewController {
    //    MARK:- Outlet
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTexetView: UITextView!
    
    
    //    MARK:- Properties
    var postData:Posts?
    var segueId = "editPost"
    var presenter:EditPostPresenterProtocol!
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = EditPostPresenter(view: self)
        if let post = self.postData{
            self.setDataForEdit(data: post)
        }
        // Do any additional setup after loading the view.
    }
    
    //    MARK:- Method
    
    func setDataForEdit(data:Posts){
        self.bodyTexetView.text = data.body ?? ""
        self.titleTextField.text = data.title ?? ""
    }
    //    MARK:- Action
    
    @IBAction func savePost(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty else{return}
        guard let body = bodyTexetView.text, !body.isEmpty else{return}
        let userId = self.postData?.userId ?? 1
        if self.postData != nil {
            self.presenter.editPost(title: title, userId: userId, body: body)
        }else{
             self.presenter.addPost(title: title, userId: userId, body: body)
        }
    }
}

extension EditPostViewController : EditPostViewProtocol{
    func updateDone(data:Posts) {
        performSegue(withIdentifier: segueId, sender: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    

    
    
}
