//
//  Router.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2021/01/16.
//

import UIKit

// 画面遷移を管理
final class Router {
    static let shared: Router = .init()
    private init() {}
    
    private var window: UIWindow!
    
    // 起動直後の画面を表示する
    func showRoot(window: UIWindow) {
        let vc = UsersViewController()
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
    
    // 詳細画面への遷移
    func showDetail(user: User, from: UIViewController) {
        let next = UserDetailViewContorller()
        next.configure(user: user)
        from.show(next: next)
    }
    
    func showAlert(user: User, from: UIViewController) {
        let alert = UIAlertController(title: user.name.fullName, message: "Hello", preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel)
        alert.addAction(close)
        
        from.present(alert, animated: true)
    }
}

//本当はUIViewController+.swiftみたいにファイルを分けよう
extension UIViewController {
    func show(next: UIViewController, animated: Bool = true) {
        if let nav = self.navigationController {
            nav.pushViewController(next, animated: animated)
        } else {
            self.present(next, animated: animated, completion: nil)
        }
    }
}
