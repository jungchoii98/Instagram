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
            likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            likeButton.heightAnchor.constraint(equalToConstant: contentView.height),
            likeButton.widthAnchor.constraint(equalToConstant: contentView.height),
            
            commentButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: padding),
            commentButton.heightAnchor.constraint(equalToConstant: contentView.height),
            commentButton.widthAnchor.constraint(equalToConstant: contentView.height),
            
            shareButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: padding),
            shareButton.heightAnchor.constraint(equalToConstant: contentView.height),
            shareButton.widthAnchor.constraint(equalToConstant: contentView.height),
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
