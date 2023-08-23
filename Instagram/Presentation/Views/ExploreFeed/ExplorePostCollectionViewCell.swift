//
//  ExplorePostCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/23/23.
//

import UIKit

class ExplorePostCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "\(ExplorePostCollectionViewCell.self)"
    
    private var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        NSLayoutConstraint.activate([
            postImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            postImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: contentView.height),
            postImageView.widthAnchor.constraint(equalToConstant: contentView.width),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    private func setUp() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(postImageView)
    }
    
    func configure(with imageURL: String) {
        postImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: "bonjour"))
    }
}
