//
//  EditPostViewController.swift
//  SocialAppTask
//
//  Created by Youxel mac5 on 1/20/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import UIKit


protocol  EditPostViewProtocol : ShowAlertProtocol {
    func updateDone()
}

class EditPostViewController: UIViewController {
    //    MARK:- Outlet
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyTexetView: UITextView!
    
    
    //    MARK:- Properties
    var postData:Posts?
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = self.postData{
            self.setDataForEdit(data: post)
        }
        // Do any additional setup after loading the view.
    }
    
    //    MARK:- Method
    
    func setDataForEdit(data:Posts){
        self.bodyTexetView.text = data.body ?? ""
        self.titleLabel.text = data.title ?? ""
    }
    //    MARK:- Action
    
    @IBAction func savePost(_ sender: UIButton) {
        if self.postData != nil {
            
        }else{
            
        }
    }
    
}
extension EditPostViewController : EditPostViewProtocol{
    func updateDone() {
        performSegue(withIdentifier: "", sender: nil)
    }
    
    func showAlert(title: String, message: String) {
        
    }
    

    
    
}
