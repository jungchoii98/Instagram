//
//  Extension+UIViewController.swift
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
    
    func presentError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
