//
//  TimestampCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import UIKit

class TimestampCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "\(TimestampCollectionViewCell.self)"
    
    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
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
            timestampLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            timestampLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            timestampLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            timestampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timestampLabel.text = nil
    }
    
    private func setUp() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(timestampLabel)
    }
    
    func configure(with viewModel: TimetampCellViewModel) {
        timestampLabel.text = viewModel.getTimestamp()
    }
}
