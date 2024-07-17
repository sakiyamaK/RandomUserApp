//
//  UIStackView+.swift
//  SampleDelegateApp
//
//  Created by sakiyamaK on 2024/07/16.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    func removeAllArrangedSubviews() {
        for view in self.arrangedSubviews {
            self.removeArrangedSubview(view)
        }
    }
}

extension UIStackView {
    @discardableResult
    func addArrangedSubview(viewBuilder: () -> UIView) -> Self {
        self.addArrangedSubview(viewBuilder())
        return self
    }
}

