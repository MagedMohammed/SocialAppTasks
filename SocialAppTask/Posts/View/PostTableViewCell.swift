//
//  PostTableViewCell.swift
//  SocialAppTask
//
//  Created by Youxel mac5 on 1/20/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    //    MARK:- Outlet
    @IBOutlet weak private var idLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    
    //    MARK:- Properties
    var delete:(()->())?
    var edit:(()->())?
    
    
    //    MARK:- ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
//    MARK:- Method
    func setCell(title:String, id:Int, body:String){
        self.titleLabel.text = title
        self.idLabel.text = "\(id)"
        self.bodyLabel.text = body
    }
    
    //    MARK:- Action
    @IBAction private func deleteAction(_ sender: UIButton) {
        self.delete?()
    }
    
    @IBAction private func editAction(_ sender: Any) {
        self.edit?()
    }
    
    
}
