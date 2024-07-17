//
//  UIScrollView+.swift
//  SampleDelegateApp
//
//  Created by sakiyamaK on 2024/07/15.
//

import UIKit

extension UIScrollView {
    
    enum ConstraintDirection {
        case vertical, horizontal, arround
    }

    func applyScrollConstraint(_ view: UIView, direction: ConstraintDirection, constants: ArroundConstraintConstants = (0, 0, 0, 0)) {
        view.translatesAutoresizingMaskIntoConstraints = false

        // viewの四隅をcontentLayoutGuideの四隅とする
        self.apply(constraints: [
            view.topAnchor.constraint(equalTo: self.contentLayoutGuide.topAnchor, constant: constants.top),
            view.leadingAnchor.constraint(equalTo: self.contentLayoutGuide.leadingAnchor, constant: constants.leading),
            view.bottomAnchor.constraint(equalTo: self.contentLayoutGuide.bottomAnchor, constant: constants.bottom),
            view.trailingAnchor.constraint(equalTo: self.contentLayoutGuide.trailingAnchor),
        ])
        
        // viewの大きさをframeLayoutの大きさにする
        let widthConstraint = view.widthAnchor.constraint(equalTo: self.frameLayoutGuide.widthAnchor, constant: -(constants.leading + constants.trailing))
        let heightConstraint = view.heightAnchor.constraint(equalTo: self.frameLayoutGuide.heightAnchor, constant: -(constants.top + constants.bottom))
        
        // スクロールさせたい方向の制約のpriorityを下げておく
        switch direction {
        case .vertical:
            self.apply(constraints: [
                widthConstraint,
                heightConstraint.priority(.init(rawValue: 1))
            ])
        case .horizontal:
            self.apply(constraints: [
                widthConstraint.priority(.init(rawValue: 1)),
                heightConstraint
            ])
        case .arround:
            self.apply(constraints: [
                widthConstraint.priority(.init(rawValue: 1)),
                heightConstraint.priority(.init(rawValue: 1))
            ])
        }
    }
    
    func applyVerticalScrollConstraint(_ view: UIView, constants: ArroundConstraintConstants = (0, 0, 0, 0)) {
        applyScrollConstraint(view, direction: .vertical, constants: constants)
    }
    
    func applyHorizontalScrollConstraint(_ view: UIView, constants: ArroundConstraintConstants = (0, 0, 0, 0)) {
        applyScrollConstraint(view, direction: .horizontal, constants: constants)
    }
}
