//
//  Log.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2024/07/17.
//

import Foundation

// デバッグビルドでしか出ない
func DLog(_ obj: Any? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    var filename: NSString = file as NSString
    filename = filename.lastPathComponent as NSString
    let text: String
    if let obj = obj {
        text = "[File:\(filename) Func:\(function) Line:\(line)] : \(obj)"
    } else {
        text = "[File:\(filename) Func:\(function) Line:\(line)]"
    }
    print(text)
}

// リリースビルドでも出る
func ALog(_ obj: Any? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    var filename: NSString = file as NSString
    filename = filename.lastPathComponent as NSString
    let text: String
    if let obj = obj {
        text = "[File:\(filename) Func:\(function) Line:\(line)] : \(obj)"
    } else {
        text = "[File:\(filename) Func:\(function) Line:\(line)]"
    }
    debugPrint(text)
}
