//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Jimin Kim on 3/9/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var studentTableView: UITableView!
    var studentLocations = [StudentLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentTableView.delegate = self
        studentTableView.dataSource = self

        API.getStudentLocations { (locations, error) in
            if error != nil {
                self.showFailure(message: error!.localizedDescription)
                return
            }
            guard locations != nil else {
                self.showFailure(message: "Student Location data could not be fetched.")
                return
            }
            self.studentLocations = locations!
            DispatchQueue.main.async {
                self.studentTableView.reloadData()
            }
        }
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        API.getStudentLocations { (locations, error) in
            if error != nil {
                self.showFailure(message: error!.localizedDescription)
                return
            }
            guard locations != nil else {
                self.showFailure(message: "Student Location data could not be fetched.")
                return
            }
            self.studentLocations = locations!
            DispatchQueue.main.async {
                self.studentTableView.reloadData()
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

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentTableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell") as! StudentTableViewCell
        
        let student = self.studentLocations[indexPath.row]
        cell.pinImage.image = UIImage(named: "Pin")
        cell.nameLabel.text = "\(student.firstName ?? " ") \(student.lastName ?? " ")"
        cell.mediaURLLabel.text = student.mediaURL
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = studentLocations[indexPath.row].mediaURL
        if let url = URL(string: url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func showFailure(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
