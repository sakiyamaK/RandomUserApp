//
//  String+.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2024/07/18.
//

import Foundation

extension String {
    var url: URL? {
        URL(string: self)
    }
}
