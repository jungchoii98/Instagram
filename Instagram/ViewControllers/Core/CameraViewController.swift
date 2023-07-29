//
//  CameraViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol CameraViewControllerDelegate: AnyObject {}

class CameraViewController: UIViewController {
    
    weak var coordinator: CameraViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}
