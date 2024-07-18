//
//  UserDetailViewContorller.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2024/07/18.
//

import UIKit
import MapKit

final class UserDetailViewContorller: UIViewController {

    private lazy var userDetailHeaderView: UserDetailHeaderView = {
        let userDetailHeaderView = UserDetailHeaderView()
        userDetailHeaderView.delegate = self
        return userDetailHeaderView
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.axis = .vertical

        self.view.addSubview(stackView)
        stackView.applyArroundConstraint(equalTo: self.view.safeAreaLayoutGuide)
        stackView.addArrangedSubview(userDetailHeaderView)
        stackView.addArrangedSubview(mapView)
    }
        
    func configure(user: User) {
        self.title = user.id.display
        userDetailHeaderView.configure(user: user)
        addAnnotation(user: user)
        centerMapOnLocation(user: user)
    }
}

private extension UserDetailViewContorller {
    func addAnnotation(user: User) {
        guard let coordinate = user.coordinate else { return }
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = user.name.fullName
        mapView.addAnnotation(annotation)
    }
    
    func centerMapOnLocation(user: User) {
        guard let coordinate = user.coordinate else { return }
        let regionRadius: CLLocationDistance = 1000 // メートル単位
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension UserDetailViewContorller: MKMapViewDelegate {
    // MKMapViewDelegateメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "UserLocation"
        var annotationView: MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if let annotationView {
            annotationView.annotation = annotation
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }

        return annotationView
    }
}

extension UserDetailViewContorller: UserDetailHeaderViewDelegate {
    func tapIcon(user: User) {
        Router.shared.showAlert(user: user, from: self)
    }
}

#Preview {
    {
        let vc = UserDetailViewContorller()
        vc.configure(user: User.sample)
        return vc
    }()
}
