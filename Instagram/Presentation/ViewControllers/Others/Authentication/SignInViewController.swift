//
//  SignInViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol SignInViewControllerDelegate: AnyObject {
    func authenticationDidSucceed()
    func didTapCreateAccount()
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
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "OR"
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private let leftDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiaryLabel
        return view
    }()
    
    private let rightDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiaryLabel
        return view
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms and Services", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var coordinator: SignInViewControllerDelegate?
    private let viewModel: AuthenticationViewModel
    
    // MARK: Lifecycle
    
    init(viewModel: AuthenticationViewModel) {
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
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerView.heightAnchor.constraint(equalToConstant: (view.height - view.safeAreaInsets.top)/3),
            
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            
            orLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orLabel.heightAnchor.constraint(equalToConstant: 20),
            orLabel.widthAnchor.constraint(equalToConstant: 25),
            
            leftDividerView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            leftDividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            leftDividerView.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -10),
            leftDividerView.heightAnchor.constraint(equalToConstant: 1),
            
            rightDividerView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            rightDividerView.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 10),
            rightDividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rightDividerView.heightAnchor.constraint(equalToConstant: 1),
            
            createAccountButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            createAccountButton.heightAnchor.constraint(equalToConstant: 40),
            
            termsButton.bottomAnchor.constraint(equalTo: privacyButton.topAnchor, constant: -5),
            termsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            termsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            termsButton.heightAnchor.constraint(equalToConstant: 20),
            
            privacyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            privacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            privacyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            privacyButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(orLabel)
        view.addSubview(leftDividerView)
        view.addSubview(rightDividerView)
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
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        showSpinner()
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              viewModel.isValidSignIn(email: email, password: password) else { return }
        
        // authenticate sign in
        viewModel.signIn(email: email, password: password) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.presentError(title: "Error", message: error?.localizedDescription ?? "Error occured while signing up")
                return
            }
            self.coordinator?.authenticationDidSucceed()
        }
    }
    
    @objc func didTapCreateAccount() {
        coordinator?.didTapCreateAccount()
    }
    
    @objc func didTapTerms() {
        coordinator?.didTapTerms()
    }
    
    @objc func didTapPrivacy() {
        coordinator?.didTapPrivacy()
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
