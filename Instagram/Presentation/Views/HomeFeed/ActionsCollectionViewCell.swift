//
//  ActionsCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import UIKit

protocol ActionsCollectionViewCellDelegate: AnyObject {
    func actionsCollectionViewCellDidTapLike(_ cell: ActionsCollectionViewCell, isLiked: Bool)
    func actionsCollectionViewCellDidTapComment(_ cell: ActionsCollectionViewCell)
    func actionsCollectionViewCellDidTapShare(_ cell: ActionsCollectionViewCell)
}

class ActionsCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "\(ActionsCollectionViewCell.self)"
    
    private var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setImage(UIImage(systemName: "message"), for: .normal)
        return button
    }()
    
    private var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return button
    }()
    
    weak var delegate: ActionsCollectionViewCellDelegate?
    private var isLiked: Bool!
    
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
        
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    @objc func didTapLike() {
        isLiked.toggle()
        updateLikeImage()
        delegate?.actionsCollectionViewCellDidTapLike(self, isLiked: isLiked)
    }
    
    @objc func didTapComment() {
        delegate?.actionsCollectionViewCellDidTapComment(self)
    }
    
    @objc func didTapShare() {
        delegate?.actionsCollectionViewCellDidTapShare(self)
    }
    
    func configure(with viewModel: ActionsCellViewModel) {
        isLiked = viewModel.isLiked
        updateLikeImage()
    }
}

private extension ActionsCollectionViewCell {
    func updateLikeImage() {
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .systemRed
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .label
        }
    }
}
