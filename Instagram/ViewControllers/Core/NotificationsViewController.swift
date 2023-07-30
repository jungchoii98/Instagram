//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol NotificationsViewControllerDelegate: AnyObject {}

class NotificationsViewController: UIViewController {
    
    weak var coordinator: NotificationsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        view.backgroundColor = .systemBackground
    }
}
