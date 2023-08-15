//
//  LikesCountCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import UIKit

class LikesCountCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "\(LikesCountCollectionViewCell.self)"
    
    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
            likesCountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            likesCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            likesCountLabel.heightAnchor.constraint(equalToConstant: contentView.height),
            likesCountLabel.widthAnchor.constraint(equalToConstant: contentView.width/5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likesCountLabel.text = nil
    }
    
    private func setUp() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(likesCountLabel)
    }
    
    func configure(with viewModel: LikesCountCellViewModel) {
        likesCountLabel.text = "\(viewModel.likers.count) Likes"
    }
}
