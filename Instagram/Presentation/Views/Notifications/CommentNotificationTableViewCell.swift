//
//  CommentNotificationTableViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/24/23.
//

import SDWebImage
import UIKit

protocol CommentNotificationTableViewCellDelegate: AnyObject {
    func commentNotificationTableViewCell(
        _ commentNotificationTableViewCell: CommentNotificationTableViewCell,
        didTapPost viewModel: CommentNotificationCellViewModel
    )
}

class CommentNotificationTableViewCell: UITableViewCell {
    static let reuseID = "\(CommentNotificationTableViewCell.self)"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    weak var delegate: CommentNotificationTableViewCellDelegate?
    private var viewModel: CommentNotificationCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(postImageView)
        
        let postTap = UITapGestureRecognizer(target: self, action: #selector(didTapPost))
        postImageView.addGestureRecognizer(postTap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapPost() {
        guard let viewModel = viewModel else { return }
        delegate?.commentNotificationTableViewCell(self, didTapPost: viewModel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: postImageView.leadingAnchor, constant: -12),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        descriptionLabel.sizeToFit()
        profileImageView.layer.cornerRadius = profileImageView.height/2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        descriptionLabel.text = nil
        postImageView.image = nil
    }
    
    func configure(with viewModel: CommentNotificationCellViewModel) {
        self.viewModel = viewModel
        profileImageView.sd_setImage(with: viewModel.profilePictureURL)
        let string = (viewModel.username + " commented on your post " + viewModel.timeAgo) as NSString
        let attributedString = NSMutableAttributedString(string: string as String)
        attributedString.addAttribute(.foregroundColor, value: UIColor.secondaryLabel, range: string.range(of: viewModel.timeAgo))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .bold), range: string.range(of: viewModel.username))
        descriptionLabel.attributedText = attributedString
        postImageView.sd_setImage(with: viewModel.postURL)
    }
}
