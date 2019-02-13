//
//  ViewController.swift
//  Mapping101
//
//  Created by Matthew Curran on 2/12/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df
    }()
    
    @IBAction func addCurrentLocationMarker(_ sender: Any) {
        if let location = locationManager.location {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            let timeStamp = dateFormatter.string(from: Date())
            annotation.title = "You were here at \(timeStamp)"
            mapView.addAnnotation(annotation)
            
            /*geoCoder.reverseGeocodeLocation(location, completionHandler: { (CLPlacemark]?, error: Error?) in self.locationText.text = "\(placeMarks![0])"
            })*/
        }
    }
    
    @IBOutlet weak var locationText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let pinAnnotation = MKPinAnnotationView()
            pinAnnotation.pinTintColor = UIColor.purple
            pinAnnotation.annotation = annotation
            pinAnnotation.canShowCallout = true
            return pinAnnotation
        }
        return nil
    }
    
    func moveToCurrentLocation() {
        if let location = locationManager.location {
            mapView.setCenter(location.coordinate, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            moveToCurrentLocation()
        } /*else {
            let alert = UIAlertController(title: "Can't display location", message: "Please grant permission in settings", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { (action: UIAlertAction) -> Void in UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!) } ))
            present(alert, animated: true, completion: nil)
        }*/
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

