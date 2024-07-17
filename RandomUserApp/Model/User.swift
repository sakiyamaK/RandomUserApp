//
//  RandomUsersResponse.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2024/07/17.
//

import UIKit
import CoreLocation

struct User: Codable {

    struct ID: Codable {
        let name: String?
        let value: String?
        // 画面表示用
        var display: String {
            value ?? "nothing"
        }
    }

    enum Gender: String, Codable {
        case male, female
        var image: UIImage {
            // rawValueでmaleなら"male"となる
            // システム上絶対画像は存在しているので!を付ける
            UIImage(named: self.rawValue)!
        }
    }
    
    struct Name: Codable {
        let first: String
        let last: String
        // 画面表示用
        var fullName: String {
            first + " " + last
        }
    }
    
    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }

    struct Location: Codable {
        struct Coordinates: Codable {
            let latitude: String
            let longitude: String
        }
        let coordinates: Coordinates
    }

    let id: ID
    let gender: Gender
    let name: Name
    let picture: Picture
    let email: String
    // Loacation自体は外部で使わないのでprivate
    private let location: Location?

    // 外部で使うCLLocationCoordinate2Dの型を用意
    // locationから変換する
    var coordinate: CLLocationCoordinate2D? {
        guard let location,
                let latitude = Double(location.coordinates.latitude),
              let longitude = Double(location.coordinates.longitude)
        else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // sample用
    init(id: ID, gender: Gender, name: Name, picture: Picture, email: String, location: Location?) {
        self.id = id
        self.gender = gender
        self.name = name
        self.picture = picture
        self.email = email
        self.location = location
    }
}

// Xcode Previewのためのダミーデータ
extension User {
    static var sample: User {
        .init(
            id: .init(name: "test", value: "10931-1930"),
            gender: .male,
            name: .init(first: "firstだよ", last: "ラストだよ"),
            picture: .init(
                large: "https://randomuser.me/api/portraits/men/75.jpg",
                medium: "https://randomuser.me/api/portraits/med/men/75.jpg",
                thumbnail: "https://randomuser.me/api/portraits/thumb/men/75.jpg"
            ),
            email: "test@gmail.com",
            location: .init(
                coordinates: .init(
                    latitude: "-69.8246",
                    longitude: "134.8719"
                )
            )
        )        
    }
}
