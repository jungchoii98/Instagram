//
//  FollowNotificationTableViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/24/23.
//

import SDWebImage
import UIKit

protocol FollowNotificationTableViewCellDelegate: AnyObject {
    func followNotificationTableViewCell(
        _ followNotificationTableViewCell: FollowNotificationTableViewCell,
        didTapFollow viewModel: FollowNotificationCellViewModel
    )
}

class FollowNotificationTableViewCell: UITableViewCell {
    static let reuseID = "\(FollowNotificationTableViewCell.self)"
    
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
    
    private let followButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    weak var delegate: FollowNotificationTableViewCellDelegate?
    private var viewModel: FollowNotificationCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(followButton)
        
        followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
    }
    
    @objc func didTapFollow() {
        self.viewModel?.isFollowing.toggle()
        updateButton()
        guard let viewModel = viewModel else { return }
        delegate?.followNotificationTableViewCell(self, didTapFollow: viewModel)
    }
    
    private func updateButton() {
        guard let viewModel = viewModel else { return }
        followButton.setTitle(viewModel.isFollowing ? "Following" : "Follow", for: .normal)
        followButton.backgroundColor = viewModel.isFollowing ? .secondarySystemBackground : .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            followButton.heightAnchor.constraint(equalToConstant: contentView.height/1.8),
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followButton.widthAnchor.constraint(equalTo: followButton.heightAnchor, multiplier: 3),
            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -12),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            

        ])
        profileImageView.layer.cornerRadius = profileImageView.height/2
        followButton.layer.cornerRadius = followButton.width/8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        descriptionLabel.text = nil
    }
    
    func configure(with viewModel: FollowNotificationCellViewModel) {
        self.viewModel = viewModel
        profileImageView.sd_setImage(with: viewModel.profilePictureURL)
        let string = (viewModel.username + " has started following you " + viewModel.timeAgo) as NSString
        let attributedString = NSMutableAttributedString(string: string as String)
        attributedString.addAttribute(.foregroundColor, value: UIColor.secondaryLabel, range: string.range(of: viewModel.timeAgo))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .bold), range: string.range(of: viewModel.username))
        descriptionLabel.attributedText = attributedString
        updateButton()
    }
}
