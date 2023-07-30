//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func didTapSettings()
}

class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileViewControllerDelegate?
    private let user: IGUser
    
    init(user: IGUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(user.username)"
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(didTapSettings)
        )
    }
    
    // MARK: Actions
    
    @objc func didTapSettings() {
        coordinator?.didTapSettings()
    }
}
