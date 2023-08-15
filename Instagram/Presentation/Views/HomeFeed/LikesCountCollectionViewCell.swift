//
//  LikesCountCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import UIKit

protocol LikesCountCollectionViewCellDelegate: AnyObject {
    func likesCountCollectionViewCellDidTapCount(_ cell: LikesCountCollectionViewCell)
}

class LikesCountCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "\(LikesCountCollectionViewCell.self)"
    
    private var likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    weak var delegate: LikesCountCollectionViewCellDelegate?
    
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
            likesCountLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            likesCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            likesCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            likesCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likesCountLabel.text = nil
    }
    
    private func setUp() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(likesCountLabel)
        
        let countTap = UITapGestureRecognizer(target: self, action: #selector(didTapCount))
        likesCountLabel.addGestureRecognizer(countTap)
    }
    
    @objc func didTapCount() {
        delegate?.likesCountCollectionViewCellDidTapCount(self)
    }
    
    func configure(with viewModel: LikesCountCellViewModel) {
        likesCountLabel.text = "\(viewModel.likers.count) Likes"
    }
}
