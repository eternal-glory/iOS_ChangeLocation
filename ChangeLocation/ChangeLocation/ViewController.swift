//
//  ViewController.swift
//  ChangeLocation
//
//  Created by JR on 2019/5/23.
//  Copyright © 2019 literature. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestWhenInUseAuthorization()
    }

}

extension ViewController: CLLocationManagerDelegate {
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currentLoction = locations.last {
            locationLabel.text = "纬度:\(currentLoction.coordinate.latitude), 经度: \(currentLoction.coordinate.longitude)"
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(currentLoction) { (placemarks, error) in
                if let placeMark = placemarks?.first {
                    
                    let country = placeMark.country ?? ""
                    let city = placeMark.locality ?? ""
                    let subLocality = placeMark.subLocality ?? ""
                    let thoroughfare = placeMark.thoroughfare ?? placeMark.name ?? ""
                    
                    self.addressLabel.text = "地址: \(country) \(city) \(subLocality) \(thoroughfare)"
                }
            }
        }
    }
}

