//
//  CaptionCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import UIKit

class CaptionCollectionViewCell: UICollectionViewCell {
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let reuseID = "\(CaptionCollectionViewCell.self)"
    
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
            captionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            captionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
    }
    
    private func setUp() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(captionLabel)
    }
    
    func configure(with viewModel: CaptionCellViewModel) {
        captionLabel.text = "\(viewModel.username): \(viewModel.caption ?? "")"
    }
}
