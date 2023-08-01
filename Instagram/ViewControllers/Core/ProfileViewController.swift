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
    private let viewModel: ProfileVCViewModel
    
    init(viewModel: ProfileVCViewModel, user: IGUser) {
        self.user = user
        self.viewModel = viewModel
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
        do {
            let isCurrentUser = try viewModel.isCurrentUser(user: user)
            if isCurrentUser {
                navigationItem.rightBarButtonItem = UIBarButtonItem(
                    image: UIImage(systemName: "gear"),
                    style: .plain,
                    target: self,
                    action: #selector(didTapSettings)
                )
            }

        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Actions
    
    @objc func didTapSettings() {
        coordinator?.didTapSettings()
    }
}

extension ProfileViewController {
    enum ProfileErrors: Error {
        case badData
    }
}
