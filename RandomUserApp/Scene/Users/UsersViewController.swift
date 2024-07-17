//
//  UsersViewController.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2024/07/17.
//

import UIKit

final class UsersViewController: UIViewController {
    
    private lazy var textField: UITextField = {
        let textField: UITextField = .init()
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()

    private lazy var closeButton: UIButton = {
        let closeButton: UIButton = .init()
        // 新しい書き方
        var config = UIButton.Configuration.plain()
        config.title = "閉じる"
        closeButton.configuration = config

        closeButton.addAction(.init(handler: { _ in
            self.view.endEditing(true)
            
        }), for: .touchUpInside)
        return closeButton
    }()

    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        return tableView
    }()
    
    private var users: [User] = []

    override func loadView() {
        super.loadView()
        self.title = "ユーザ検索"
        self.view.backgroundColor = .white
        
        let mainStackView: UIStackView = .init()
        mainStackView.axis = .vertical

        self.view.addSubview(mainStackView)
        
        mainStackView.applyArroundConstraint(equalTo: self.view.safeAreaLayoutGuide)
        
        let topStackView: UIStackView = .init()
        topStackView.axis = .horizontal
        topStackView.spacing = 10
        topStackView.addArrangedSubview(textField)
        topStackView.addArrangedSubview(closeButton)

        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(tableView)
    }
}

extension UsersViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        DLog(textField.text)
        guard 
            let text = textField.text,
            let count = Int(text) else {
            return
        }
        
        Task { @MainActor in
            do {
                self.users = try await API.shared.getUsers(count: count)
                DLog(self.users.count)
                tableView.reloadData()
            } catch let error {
                DLog(error)
            }
        }
    }
}
extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.item]
        Router.shared.showDetail(user: user, from: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1行なのでreturnが不要
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.item]
        cell.configure(user: user)
        return cell
    }
}

#Preview {
    UsersViewController()
}
