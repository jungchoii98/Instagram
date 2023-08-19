//
//  PosterCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import SDWebImage
import UIKit

protocol PosterCollectionViewCellDelegate: AnyObject {
    func posterCollectionViewCellDidTapUsername(_ cell: PosterCollectionViewCell, with username: String)
    func posterCollectionViewCellDidTapMore(_ cell: PosterCollectionViewCell)
}

class PosterCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "\(PosterCollectionViewCell.self)"
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.label.cgColor
        return imageView
    }()
    
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.sizeToFit()
        return label
    }()
    
    private var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    weak var delegate: PosterCollectionViewCellDelegate?
    private var username: String!
    
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
        avatarImageView.layer.cornerRadius = (contentView.height-padding)/2
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: contentView.height - padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: contentView.height - padding),
            
            usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            usernameLabel.widthAnchor.constraint(equalToConstant: contentView.width/2),
            usernameLabel.heightAnchor.constraint(equalToConstant: contentView.height - padding),
            
            moreButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            moreButton.heightAnchor.constraint(equalToConstant: contentView.height - padding),
            moreButton.widthAnchor.constraint(equalToConstant: contentView.width/6)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        usernameLabel.text = nil
    }
    
    private func setUp() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        
        let usernameTap = UITapGestureRecognizer(target: self, action: #selector(tappedUsername))
        usernameLabel.addGestureRecognizer(usernameTap)
        moreButton.addTarget(self, action: #selector(tappedMoreButton), for: .touchUpInside)
    }
    
    @objc func tappedUsername() {
        delegate?.posterCollectionViewCellDidTapUsername(self, with: username)
    }
    
    @objc func tappedMoreButton() {
        delegate?.posterCollectionViewCellDidTapMore(self)
    }
    
    func configure(with viewModel: PosterCellViewModel) {
        avatarImageView.sd_setImage(with: viewModel.avatarImageURL, placeholderImage: UIImage(systemName: "wifi.slash"))
        usernameLabel.text = viewModel.username
        username = viewModel.username
    }
}
