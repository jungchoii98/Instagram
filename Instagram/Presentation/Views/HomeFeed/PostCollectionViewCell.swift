//
//  PostCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import SDWebImage
import UIKit

protocol PostCollectionViewCellDelegate: AnyObject {
    func postCollectionViewCellDidDoubleTap(_ cell: PostCollectionViewCell)
}

class PostCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "\(PostCollectionViewCell.self)"
    
    private var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemRed
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.alpha = 0
        imageView.isHidden = true
        return imageView
    }()
    
    weak var delegate: PostCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            postImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            postImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: contentView.height),
            postImageView.widthAnchor.constraint(equalToConstant: contentView.width),
            
            heartImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heartImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            heartImageView.heightAnchor.constraint(equalToConstant: contentView.height/2),
            heartImageView.widthAnchor.constraint(equalToConstant: contentView.width/2),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    private func setUp() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(postImageView)
        contentView.addSubview(heartImageView)
        
        let imageDoubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
        imageDoubleTap.numberOfTapsRequired = 2
        postImageView.addGestureRecognizer(imageDoubleTap)
    }
    
    @objc func didDoubleTap() {
        displayHeartAnimation()
        delegate?.postCollectionViewCellDidDoubleTap(self)
    }
    
    func configure(with viewModel: PostCellViewModel) {
        postImageView.sd_setImage(with: viewModel.postImageURL, placeholderImage: UIImage(systemName: "wifi.slash"))
    }
}

private extension PostCollectionViewCell {
    func displayHeartAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.heartImageView.isHidden = false
            self.heartImageView.alpha = 1
        }) { [weak self] isDone in
            if isDone {
                UIView.animate(withDuration: 0.5, animations: {
                    self?.heartImageView.alpha = 0
                }) { [weak self] isDone in
                    if isDone {
                        self?.heartImageView.isHidden = true
                    }
                }
            }
        }
    }
}
