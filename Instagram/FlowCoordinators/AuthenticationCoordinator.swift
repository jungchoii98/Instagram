//
//  AuthenticationFlowCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import SafariServices
import UIKit

protocol AuthenticationCoordinatorDelegate: AnyObject {
    func didAuthenticate(child: Coordinator)
}

final class AuthenticationCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: AuthenticationCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSignIn()
    }
    
    private func showSignIn() {
        let viewModel = AuthenticationViewModel()
        let signInVC = SignInViewController(viewModel: viewModel)
        signInVC.coordinator = self
        navigationController.pushViewController(signInVC, animated: true)
    }
    
    private func showSignUp() {
        let viewModel = AuthenticationViewModel()
        let signUpVC = SignUpViewController(viewModel: viewModel)
        signUpVC.coordinator = self
        navigationController.pushViewController(signUpVC, animated: true)
    }
}

extension AuthenticationCoordinator: SignInViewControllerDelegate, SignUpViewControllerDelegate {
    func authenticationDidSucceed() {
        delegate?.didAuthenticate(child: self)
    }
    
    func didTapCreateAccount() {
        showSignUp()
    }
    
    func didTapTerms() {
        guard let url = URL(string: "http://www.instagram.com") else { return }
        let vc = SFSafariViewController(url: url)
        navigationController.present(vc, animated: true)
    }
    
    func didTapPrivacy() {
        guard let url = URL(string: "http://www.instagram.com") else { return }
        let vc = SFSafariViewController(url: url)
        navigationController.present(vc, animated: true)
    }
}
