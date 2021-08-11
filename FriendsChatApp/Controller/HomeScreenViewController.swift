//
//  HomeScreenViewController.swift
//  FriendsChatApp
//
//  Created by Desha Washington on 6/30/21.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel!.text = "FriendsChatApp"
    }
}
