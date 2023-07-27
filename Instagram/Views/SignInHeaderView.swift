//
//  SignInHeaderView.swift
//  Instagram
//
//  Created by Jung Choi on 7/27/23.
//

import UIKit

class SignInHeaderView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var gradientLayer: CAGradientLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        createGradient()
        addSubview(logoImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
        logoImageView.frame = CGRect(x: width/4, y: 20, width: width/2, height: height-40)
    }
    
    private func createGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        layer.addSublayer(gradientLayer)
    }
}
