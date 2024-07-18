//
//  UserDetailHeaderView.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2024/07/18.
//

import UIKit

protocol UserDetailHeaderViewDelegate {
    func tapIcon(user: User)
}

final class UserDetailHeaderView: UIView {
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
        let size: CGFloat = 100
        imageView.apply(constraints: [
            imageView.heightAnchor.constraint(equalToConstant: size),
            imageView.widthAnchor.constraint(equalToConstant: size)
        ])
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapIcon)))
        return imageView
    }()
    
    private lazy var genderIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        let size: CGFloat = 30
        imageView.apply(constraints: [
            imageView.heightAnchor.constraint(equalToConstant: size),
            imageView.widthAnchor.constraint(equalToConstant: size)
        ])
        return imageView
    }()
    
    private var userFullNameLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        userIconView.addSubview(genderIconView)
        userIconView.translatesAutoresizingMaskIntoConstraints = false
        genderIconView.apply(constraints: [
            genderIconView.rightAnchor.constraint(equalTo: userIconView.rightAnchor),
            genderIconView.bottomAnchor.constraint(equalTo: userIconView.bottomAnchor),
        ])
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        self.addSubview(mainStackView)
        mainStackView.applyArroundConstraint(equalTo: self, constants: (12, 12, 12, 12))
        
        let centerStackView = UIStackView()
        centerStackView.axis = .vertical
        centerStackView.alignment = .center
        
        centerStackView.addArrangedSubview(userIconView)
        
        mainStackView.addArrangedSubview(centerStackView)
        mainStackView.addArrangedSubview(userFullNameLabel)
    }
    
    var delegate: UserDetailHeaderViewDelegate?
    
    private var user: User!
    func configure(user: User) {
        self.user = user
        userIconView.kf.setImage(with: user.picture.large.url)
        userFullNameLabel.text = user.name.fullName        
        genderIconView.image = user.gender.image
    }

    @objc func tapIcon() {
        delegate?.tapIcon(user: user)
    }
}
