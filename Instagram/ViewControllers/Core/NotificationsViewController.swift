//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol NotificationsViewControllerDelegate: AnyObject {}

class NotificationsViewController: UIViewController {
    
    weak var delegate: NotificationsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}
