//
//  ViewController.swift
//  ManiuMental
//
//  Created by Khadir Baaoua on 31/05/2016.
//  Copyright © 2016 Atlastic. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var latitudeLabel: UITextField!
    @IBOutlet weak var longitudeLabel: UITextField!
    @IBOutlet weak var accuracyManager: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(htmlEncodedString: "\u{2022}"))
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.spinner.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        print("New location : \(locations)")
        if let newLocation = locations.last {
            self.latitudeLabel.text = String(format: "%.2f", newLocation.coordinate.latitude);
            self.longitudeLabel.text = String(format: "%.2f", newLocation.coordinate.longitude);
            self.accuracyManager.text = String(format: "%.1fm", newLocation.horizontalAccuracy);
            self.spinner.stopAnimating()
        } else {
            print("No location found")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error:NSError) {
        self.latitudeLabel.text = "-"
        self.longitudeLabel.text = "-"
        self.accuracyManager.text = "-"
        self.spinner.startAnimating();
    }

}

