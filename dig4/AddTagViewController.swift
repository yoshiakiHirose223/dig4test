//
//  AddTagViewController.swift
//  dig
//
//  Created by 廣瀬由明 on 2019/10/31.
//  Copyright © 2019 廣瀬由明. All rights reserved.
//

import UIKit

class AddTagViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var textField: UITextField!
    var tableView: UITableView!
    var backButton: UIButton!
    
    //タグ格納
    var tagArray: [String]!
    
    //戻った時にさせたい処理
    var postDismissAction: ( () -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsInit()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
        print("\(self.view.safeAreaInsets)")
        viewsLayout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = tagArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 4
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tagArray[indexPath.row] = ""
            var removedTagArray = tagArray.filter { (tag) -> Bool in
                if tag == "" {
                    return false
                } else {
                    return true
                }
            }
            let blankCount = 4 - removedTagArray.count
            for _ in 0..<blankCount {
                removedTagArray.append("")
            }
            self.tagArray = removedTagArray
            tableView.reloadData()
        }
    }
    
    func didTapAddTagButton (completion: (() -> Void)?) {

        guard textField.text != "" else { completion?()
            return }
        let text = textField.text!
        if text.count <= 7 {
            if tagArray[0] == "" {
                tagArray[0] = text
                textField.text = nil
                tableView.reloadData()
                completion?()
            } else if tagArray[1] == "" {
                tagArray[1] = text
                textField.text = nil
                tableView.reloadData()
                completion?()
            } else if tagArray[2] == "" {
                tagArray[2] = text
                textField.text = nil
                tableView.reloadData()
                completion?()
            } else if tagArray[3] == "" {
                tagArray[3] = text
                textField.text = nil
                tableView.reloadData()
                completion?()
            }
        } else if text.count > 7{
            let alertView = AlertView(frame: textField.frame)
            alertView.alert.text = "文字数オーバー"
            self.view.addSubview(alertView)
            alertView.alpha = 2.0
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
                alertView.alpha = 0.7
            }) { (completion) in
                self.textField.text = nil
                alertView.removeFromSuperview()
            }
        }
    }
    
    @objc func didTapBackButton (_ sender: UIButton) {
        //Textが入っていたら、TagArrayに入れてdismiss
        //Textが入っていなかったら、そのままdismiss
        //->
        didTapAddTagButton {
            //完了ボタンを押した時の処理
            let navigationController = self.presentingViewController as! UINavigationController
            let viewcontrollersCount = navigationController.viewControllers.count
            let createVC = navigationController.viewControllers[viewcontrollersCount - 1] as! CreateTweetViewController
            createVC.tagArray = self.tagArray
            //値を写したらリセットする
            self.textField.text = nil
            self.dismiss(animated: true) {
                self.postDismissAction!()
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        didTapAddTagButton(completion: nil)
        return true
    }
    
    
    func viewsInit () {
        /*
         textField = UITextField(frame: CGRect(x: 0, y: 0, width: textFieldWidth, height: textFieldHeight))
         addTagButton = UIButton(frame: CGRect(x: 0, y: 0, width: addTagButtonWidth, height: addTagButtonHeight))
         tableView = UITableView(frame: CGRect(x: 0, y: 0, width: tableViewWidth, height: tableViewHeight))
         backButton = UIButton(frame: CGRect(x: 0, y: 0, width: backButtonWidth, height: backButtonHeight))*/
        textField = UITextField()
        tableView = UITableView()
        backButton = UIButton(type: .system)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        textField.backgroundColor = .white
        backButton.backgroundColor = .cyan
        
        textField.placeholder = "7文字以内で入力してください"
        textField.delegate = self

        backButton.setTitle("完了", for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        
        self.view.addSubview(textField)
        self.view.addSubview(tableView)
        self.view.addSubview(backButton)
    }
    
    func viewsLayout () {
        let myView = self.view.frame
        //大きさ
        let textFieldWidth = myView.width
        let textFieldHeight = myView.height * 0.2
        
        let tableViewWidth = myView.width
        let tableViewHeight = myView.height * 0.6
        
        let backButtonWidth = myView.width
        let backButtonHeight = myView.height * 0.2
        
        textField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        textField.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        
        tableView.widthAnchor.constraint(equalToConstant: tableViewWidth).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: tableViewHeight).isActive = true
        tableView.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        backButton.widthAnchor.constraint(equalToConstant: backButtonWidth).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: backButtonHeight).isActive = true
        backButton.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        backButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
}
