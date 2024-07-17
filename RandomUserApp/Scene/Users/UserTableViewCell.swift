//
//  UserTableViewCell.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2024/07/17.
//

import UIKit
import Kingfisher

final class UserTableViewCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var userIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        let size: CGFloat = 50
        imageView.apply(constraints: [
            imageView.heightAnchor.constraint(equalToConstant: size),
            imageView.widthAnchor.constraint(equalToConstant: size)
        ])
        imageView.layer.cornerRadius = size/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var genderIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        let size: CGFloat = 50
        imageView.apply(constraints: [
            imageView.heightAnchor.constraint(equalToConstant: size),
            imageView.widthAnchor.constraint(equalToConstant: size)
        ])
        return imageView
    }()

    private lazy var userIDLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        return label
    }()

    private lazy var userFullNameLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let hStackView = UIStackView()
        hStackView.axis = .horizontal
        hStackView.alignment = .center
        hStackView.spacing = 12

        self.contentView.addSubview(hStackView)
        hStackView.applyArroundConstraint(
            equalTo: self.contentView,
            constants: (12, 12, 12, 12)
        )
        
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.spacing = 8

        hStackView.addArrangedSubview(userIconView)
        hStackView.addArrangedSubview(vStackView)
        // genderIconViewを右端に寄せるために間にUIView()を挟む
        hStackView.addArrangedSubview(UIView())
        hStackView.addArrangedSubview(genderIconView)
        
        vStackView.addArrangedSubview(userIDLabel)
        vStackView.addArrangedSubview(userFullNameLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userIconView.image = nil
        userIDLabel.text = nil
        userFullNameLabel.text = nil
        genderIconView.image = nil
    }
    
    func configure(user: User) {
        userIconView.kf.setImage(with: user.picture.thumbnail.url)
        userIDLabel.text = user.id.display
        userFullNameLabel.text = user.name.fullName
        genderIconView.image = user.gender.image
    }
}
