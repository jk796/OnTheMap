//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Jimin Kim on 1/16/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var locations = [StudentLocation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        API.getStudentLocations { (locations, error) in
            if error != nil {
                self.showFailure(message: error!.localizedDescription)
                return
            }
            
            guard locations != nil else {
                self.showFailure(message: "Student Location data could not be fetched.")
                return
            }
            
            var annotations = [MKAnnotation]()
            
            for location in locations! {
                let lat = CLLocationDegrees(location.latitude as! Double)
                let long = CLLocationDegrees(location.longitude as! Double)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let first = location.firstName as! String
                let last = location.lastName as! String
                let mediaURL = location.mediaURL as! String
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                
                annotations.append(annotation)
                
            }
            DispatchQueue.main.async {
                self.mapView.addAnnotations(annotations)
            }
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        API.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                let toOpenURL = URL(string: toOpen)
                if toOpenURL == nil {
                    showFailure(message: "The URL is not provided")
                } else {
                    app.openURL(toOpenURL!)
                }
            }
        }
    }
    
    func showFailure(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
