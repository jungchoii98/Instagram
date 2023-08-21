//
//  CaptionViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

class CaptionViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Add a caption..."
        textView.textColor = .placeholderText
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = .secondarySystemBackground
        return textView
    }()
    
    private let image: UIImage
    private let viewModel: CaptionVCViewModel
    
    init(image: UIImage, viewModel: CaptionVCViewModel) {
        self.image = image
        imageView.image = image
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        title = "Add Caption"
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(textView)
        textView.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissTextView)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(didTapPost))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.width/5),
            imageView.heightAnchor.constraint(equalToConstant: view.width/5),
            
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            textView.heightAnchor.constraint(equalToConstant: view.height/5)
        ])
    }
    
    @objc func didTapPost() {
        dismissTextView()
        guard let caption = textView.text == "Add a caption..." ? "" : textView.text else { return }
        showSpinner()
        viewModel.createPost(pictureData: image.pngData(), caption: caption)
    }
}

private extension CaptionViewController {
    @objc func dismissTextView() {
        textView.resignFirstResponder()
    }
}

extension CaptionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .placeholderText
            textView.text = "Add a caption..."
        }
    }
}

extension CaptionViewController: CaptionVCViewModelDelegate {
    func captionVCViewModelDidSucceedToPost(_ captionVCViewModel: CaptionVCViewModel) {
        dismissSpinner()
        navigationController?.popToRootViewController(animated: true)
        tabBarController?.selectedIndex = 0
        tabBarController?.tabBar.isHidden = false
    }
    
    func captionVCViewModelDidFailToPost(_ captionVCViewModel: CaptionVCViewModel) {
        dismissSpinner()
        print("failed to post")
    }
}
