//
//  ActionsCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import UIKit

class ActionsCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "\(ActionsCollectionViewCell.self)"
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setImage(UIImage(systemName: "message"), for: .normal)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            likeButton.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            
            commentButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            commentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: padding),
            commentButton.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            
            shareButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            shareButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: padding),
            shareButton.widthAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.imageView?.image = nil
        commentButton.imageView?.image = nil
        shareButton.imageView?.image = nil
    }
    
    private func setUp() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
    }
    
    func configure(with viewModel: ActionsCellViewModel) {
        if viewModel.isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .systemRed
        }
    }
}
