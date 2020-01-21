//
//  ViewController.swift
//  SocialAppTask
//
//  Created by Youxel mac5 on 1/20/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import UIKit


protocol  PostListViewProtocol{
    func setPost(data:[Posts])
    func showAlert(title:String, message:String)
}

class PostListViewControoler: UIViewController {
    
    //    MARK:- Outlet
    
    @IBOutlet weak var postTableView : UITableView!
    
    //    MARK:- Properties
    var postsData = [Posts]()
    var cellId = "PostTableViewCell"
    var presenter : PostsListPresenterProtocol!
    var deletedPostId = 0
    var segueId = "editPost"
    
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfuger()
        self.presenter = PostsListPresenter(view: self)
        self.presenter.getPostsData()
    }
    
    //    MARK:- Method
    func tableViewConfuger(){
        self.postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        self.postTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            if let destination = segue.destination as? EditPostViewController {
                if let post = sender as? Posts {
                    destination.postData = post
                }
            }
        }
    }
    
    //    MARK:- Action
    
}

extension PostListViewControoler: PostListViewProtocol{
    func setPost(data: [Posts]) {
        self.postsData = data
        self.postTableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true) {
            self.postTableView.reloadData()
        }
    }
}

extension PostListViewControoler: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PostTableViewCell
        let title = postsData[indexPath.row].title ?? ""
        let id = postsData[indexPath.row].id ?? 0
        let body = postsData[indexPath.row].body ?? ""
        cell.setCell(title: title, id: id, body: body)
        cell.delete = { [weak self] in
            guard let self = self else{return}
            let id = self.postsData[indexPath.row].id ?? 0
            self.presenter.deletePost(id: id)
            self.self.postsData.remove(at:indexPath.row)
            print("delete Cell")
        }
        cell.edit = { [weak self] in
            guard let self = self else{return}
            print("edit Cell")
            let post = self.postsData[indexPath.row]
            self.performSegue(withIdentifier: self.segueId, sender: post)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.postTableView.isDragging{
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
}
