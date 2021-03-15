//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Jimin Kim on 3/10/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import UIKit
import CoreLocation

class InformationPostingViewController: UIViewController {
    
    var mapString: String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?
    var coordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var linkTextField: UITextField!
    
    @IBOutlet weak var findLocationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findLocationButton.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }
    
    @IBAction func findLocationTapped(_ sender: Any) {
        if locationTextField.text == "" || linkTextField.text == "" {
            showFailure(message: "Both location and link need to be specified")
            return
        }
        setLoggingIn(true)
        CLGeocoder().geocodeAddressString(locationTextField.text!) { (placeMarks, error) in
            if error != nil {
                self.showFailure(message: error!.localizedDescription)
                self.setLoggingIn(false)
                return
            }
            self.mapString = self.locationTextField.text
            self.mediaURL = self.linkTextField.text
            self.coordinate = placeMarks?.first?.location?.coordinate
            self.latitude = placeMarks?.first?.location?.coordinate.latitude
            self.longitude = placeMarks?.first?.location?.coordinate.longitude
            self.setLoggingIn(false)
            self.performSegue(withIdentifier: "ShowOnMap", sender: nil)
            //placeMarks?.first?.location?.coordinate
        }
        
        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOnMap" {
            let vc = segue.destination as! ZoomedViewController
            vc.mapString = mapString
            vc.mediaURL = mediaURL
            vc.latitude = latitude
            vc.longitude = longitude
            vc.coordinate = coordinate
        }
    }
    
    func showFailure(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
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
