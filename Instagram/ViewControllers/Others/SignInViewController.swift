//
//  SignInViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol SignInViewControllerDelegate: AnyObject {
    func authenticationDidSucceed()
    func didTapSignUp()
    func didTapTerms()
    func didTapPrivacy()
}

class SignInViewController: UIViewController {
    
    // MARK: Subviews
    
    private let headerView = SignInHeaderView()
    
    private let emailTextField: IGTextField = {
        let textField = IGTextField()
        textField.placeholder = "Email Address"
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let passwordTextField: IGTextField = {
        let textField = IGTextField()
        textField.placeholder = "Password"
        textField.keyboardType = .default
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms and Services", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        return button
    }()
    
    weak var delegate: SignInViewControllerDelegate?
    private let viewModel: SignInVCViewModel
    
    // MARK: Lifecycle
    
    init(viewModel: SignInVCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        addSubviews()
        addActions()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        headerView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: (view.height - view.safeAreaInsets.top)/3
        )
        emailTextField.frame = CGRect(
            x: 20,
            y: headerView.bottom + 20,
            width: view.width-40,
            height: 50
        )
        passwordTextField.frame = CGRect(
            x: 20,
            y: emailTextField.bottom + 10,
            width: view.width-40,
            height: 50
        )
        signInButton.frame = CGRect(
            x: 150,
            y: passwordTextField.bottom + 20,
            width: view.width/4,
            height: 50
        )
        createAccountButton.frame = CGRect(
            x: 100,
            y: signInButton.bottom + 20,
            width: view.width/2,
            height: 30
        )
        termsButton.frame = CGRect(
            x: 100,
            y: createAccountButton.bottom + 50,
            width: view.width/2,
            height: 30
        )
        privacyButton.frame = CGRect(
            x: 100,
            y: termsButton.bottom + 50,
            width: view.width/2,
            height: 30
        )
    }
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    private func addActions() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    
    @objc func didTapSignIn() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              viewModel.isValidSignIn(email: email, password: password)
        else {
            return
        }
        
        // authenticate sign in
        delegate?.authenticationDidSucceed()
        print("authenticating...")
    }
    
    @objc func didTapCreateAccount() {
        delegate?.didTapSignUp()
    }
    
    @objc func didTapTerms() {
        delegate?.didTapTerms()
    }
    
    @objc func didTapPrivacy() {
        delegate?.didTapPrivacy()
    }
}

// MARK: Delegates

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
            didTapSignIn()
        }
        return true
    }
}
