//
//  Extensions+UIViewController.swift
//  Instagram
//
//  Created by Jung Choi on 8/1/23.
//

import UIKit

fileprivate var containerView: UIView?

extension UIViewController {
    
    func showSpinner() {
        containerView = UIView()
        guard let containerView = containerView else { return }
        containerView.alpha = 0.8
        containerView.backgroundColor = .systemBackground
        containerView.frame = view.bounds
        view.addSubview(containerView)
        let spinner = UIActivityIndicatorView()
        containerView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        spinner.startAnimating()
    }
    
    func dismissSpinner() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }
}
