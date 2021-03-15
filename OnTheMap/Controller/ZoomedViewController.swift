//
//  ZoomedViewController.swift
//  OnTheMap
//
//  Created by Jimin Kim on 3/10/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import UIKit
import MapKit

class ZoomedViewController: UIViewController, MKMapViewDelegate {
    
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?
    var coordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        finishButton.layer.cornerRadius = 5
        
        let annotation = MKPointAnnotation()
        annotation.title = mapString
        annotation.subtitle = mediaURL
        annotation.coordinate = coordinate!
        self.mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate!, span: span)
        self.mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        
        API.getUser(completion: handleGetUserResponse(user:error:))
        
    }
    
    func handleGetUserResponse(user: User?, error: Error?) {
        if error != nil {
            showLoginFailure(message: error?.localizedDescription ?? "")
        } else {
            API.postUser(firstName: (user?.firstName)!, lastName: (user?.lastName)!, mapString: self.mapString!, mediaURL: self.mediaURL!, latitude: self.latitude!, longitude: self.longitude!, completion: handlePostUserResponse(success:error:))
            
        }
    }
    
    func handlePostUserResponse(success: Bool, error: Error?) {
        if error != nil {
            showLoginFailure(message: error?.localizedDescription ?? "")
        } else {
            DispatchQueue.main.async {
                self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
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
    
    func showLoginFailure(message: String) {
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
