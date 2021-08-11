//
//  MessagesTableViewController.swift
//  FriendsChatApp
//
//  Created by Desha Washington on 6/30/21.
//

import FirebaseFirestore
import UIKit
import Firebase

class MessagesTableViewController: UIViewController {

    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    let db = Firestore.firestore()

    var messages: [Messages] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        title = "FriendChatApp"

        navigationItem.hidesBackButton = true

        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()

    }
    func loadMessages() {


        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in

            self.messages = []

            if let e = error {
                print("Error retrieving data from firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Messages(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)


                            DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }

    @IBAction func sendPressed(_ sender: UIButton) {

        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("Error saving data to the firestore, \(e)")
                } else {
                    print("Successfully saved data.")

                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }

    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
         do {
           try Auth.auth().signOut()
           navigationController?.popToRootViewController(animated: true)
         } catch let signOutError as NSError {
             let alert = UIAlertController(title: "Error logging in", message: signOutError.localizedDescription, preferredStyle: UIAlertController.Style.alert)
             // add an action (button)
             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
             // show the alert
             self.present(alert, animated: true, completion: nil)
             }
         }

//        do {
//          try Auth.auth().signOut()
//
//            navigationController?.popToRootViewController(animated: true)
//
//        } catch let signOutError as NSError {
//          print ("Error signing out: %@", signOutError)
//        }
//    }
//    private func alertError(title: String, message: String) {
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "Ok", style: .default))
//        present(alertVC, animated: true)
    }



extension MessagesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessagesTableViewCell
        cell.label.text = message.body


        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.lightGray
            cell.label.textColor = UIColor.white
        }
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor.white
            cell.label.textColor = UIColor.black

        }

        return cell
    }
}
