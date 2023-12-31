//
//  CameraEditViewController.swift
//  Instagram
//
//  Created by Jung Choi on 8/19/23.
//

import AVFoundation
import UIKit

protocol CameraEditViewControllerDelegate: AnyObject {
    func cameraEditViewControllerDidTapNext(_ cameraEditViewController: CameraEditViewController, with image: UIImage)
}

class CameraEditViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let image: UIImage
    
    weak var coordinator: CameraEditViewControllerDelegate?
    
    init(image: UIImage) {
        self.image = image
        imageView.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit"
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(imageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(didTapNext))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.width),
        ])
    }
    
    @objc func didTapNext() {
        coordinator?.cameraEditViewControllerDidTapNext(self, with: image.resized(width: 640, height: 640))
    }
}
