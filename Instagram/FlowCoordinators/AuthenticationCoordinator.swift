//
//  AuthenticationFlowCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import SafariServices
import UIKit

protocol AuthenticationCoordinatorDelegate: AnyObject {
    func didAuthenticate()
}

final class AuthenticationCoordinator: Coordinator {
    
    weak var delegate: AuthenticationCoordinatorDelegate?
    private let navigationController: UINavigationController
    private var signInVC: SignInViewController!
    private var signUpVC: SignUpViewController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSignIn()
    }
    
    private func showSignIn() {
        let signInVCViewModel = SignInVCViewModel()
        signInVC = SignInViewController(viewModel: signInVCViewModel)
        signInVC.delegate = self
        navigationController.pushViewController(signInVC, animated: true)
    }
    
    private func showSignUp() {
        signUpVC = SignUpViewController()
        signUpVC.delegate = self
        navigationController.pushViewController(signUpVC, animated: true)
    }
}

extension AuthenticationCoordinator: SignInViewControllerDelegate {
    func authenticationDidSucceed() {
    }
    
    func didTapSignUp() {
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

extension AuthenticationCoordinator: SignUpViewControllerDelegate {}
