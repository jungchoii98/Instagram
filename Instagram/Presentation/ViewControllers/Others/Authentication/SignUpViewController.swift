//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol SignUpViewControllerDelegate: AnyObject {
    func authenticationDidSucceed()
    func didTapTerms()
    func didTapPrivacy()
}

class SignUpViewController: UIViewController {
    
    // MARK: Subviews
    
    private let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.layer.cornerRadius = 45
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameTextField: IGTextField = {
        let textField = IGTextField()
        textField.placeholder = "Username"
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTextField: IGTextField = {
        let textField = IGTextField()
        textField.placeholder = "Email Address"
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: IGTextField = {
        let textField = IGTextField()
        textField.placeholder = "Password"
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
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
    
    weak var coordinator: SignUpViewControllerDelegate?
    private let viewModel: AuthenticationViewModel
    
    init(
        viewModel: AuthenticationViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Acccount"
        view.backgroundColor = .systemBackground
        addSubviews()
        addActions()
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        addProfilePictureImageGesture()
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.activate([
            profilePictureImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profilePictureImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePictureImageView.heightAnchor.constraint(equalToConstant: 90),
            profilePictureImageView.widthAnchor.constraint(equalToConstant: 90),
            
            usernameTextField.topAnchor.constraint(equalTo: profilePictureImageView.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            
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
    
    func addSubviews() {
        view.addSubview(profilePictureImageView)
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    private func addActions() {
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }
    
    private func addProfilePictureImageGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePicture))
        profilePictureImageView.isUserInteractionEnabled = true
        profilePictureImageView.addGestureRecognizer(gesture)
    }
    
    // MARK: Actions
    
    @objc func didTapProfilePicture() {
        let alertController = UIAlertController(title: "Profile Picture Selection", message: "Please Submit a Profile Picture for Display", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] action in
            guard let self = self else { return }
            let cameraPicker = UIImagePickerControllerAdapter().getCameraPickerController()
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true)
        }
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] action in
            guard let self = self else { return }
            let libraryPicker = UIImagePickerControllerAdapter().getLibraryPickerController()
            libraryPicker.delegate = self
            self.present(libraryPicker, animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        present(alertController, animated: true)
    }
    
    @objc func didTapSignUp() {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        showSpinner()
        guard let username = usernameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              viewModel.isValidSignUp(username: username,email: email, password: password) else {
            presentError(title: "Woops", message: "Please make sure the username and password are valid.")
            return
        }
        
        // authenticate sign in
        viewModel.signUp(email: email, password: password, username: username, profileImageData: profilePictureImageView.image?.pngData()) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.presentError(title: "Error", message: error?.localizedDescription ?? "Error occured while signing up")
                return
            }
            self.dismissSpinner()
            self.coordinator?.authenticationDidSucceed()
            
        }
    }
    
    @objc func didTapTerms() {
        coordinator?.didTapTerms()
    }
    
    @objc func didTapPrivacy() {
        coordinator?.didTapPrivacy()
    }
}

// MARK: Delegates

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
            didTapSignUp()
        }
        return true
    }
}

extension SignUpViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        DispatchQueue.main.async {
            let image = info[.originalImage] as? UIImage
            self.profilePictureImageView.image = image
            picker.dismiss(animated: true)
        }
    }
}
