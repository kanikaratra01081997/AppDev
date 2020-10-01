//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db=Firestore.firestore()
    
    var messages:[Message] = [Message(sender:"kan@rad.com", body: "hi")]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        tableView.dataSource = self
        navigationItem.hidesBackButton=true
        title=K.appName
        
     LoadMessages()
    }
    
    
    func LoadMessages(){
             
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, err) in
                self.messages=[]
                if let err = err {
                     print("Error getting documents: \(err)")
                 } else {
                     for document in querySnapshot!.documents {
                         let dat = document.data()
                         if let messageSender = dat[K.FStore.senderField] as? String , let messageBody = dat[K.FStore.bodyField] as? String{
                         let newMessage = Message(sender: messageSender, body: messageBody)
                             self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData() //section 0 depicts iphone setting ka section
                                let indexPath=IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                         
                         }
                         
                     }
                 }
             }

             
         }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:messageSender ,K.FStore.bodyField:messageBody, K.FStore.dateField:Date().timeIntervalSince1970]) { (error) in
                if let e = error{
                    print("issue storing the data in database \(e)")
                }
                else{
                    print("data is saved securely")
                    DispatchQueue.main.async {
                         self.messageTextfield.text=""
                    }
                   
                }
            }
            
        }
       
        
        
        
    }
    
    @IBAction func LogoutPressed(_ sender: UIBarButtonItem) {
        //let firebaseAuth = Auth.auth()
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count //count of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               // we create cell for row here //called for no. of rows
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)  as! MessageCell//it resuable cell
        cell.label.text = messages[(indexPath.row)].body
        
        let m=messages[indexPath.row]
        //message from current user
        if(m.sender == Auth.auth().currentUser?.email){
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor=UIColor(named: K.BrandColors.purple)
        }
        else if(m.sender != Auth.auth().currentUser?.email)
        {
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
           
            cell.messageBubble.backgroundColor=UIColor(named: K.BrandColors.purple)
            cell.label.textColor=UIColor(named: K.BrandColors.lightPurple)
        }
 
       
        return cell
    }
}


