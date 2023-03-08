//
//  ViewController.swift
//  Cry Log
//
//  Created by Idris Mahamdi on 27/01/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController{
  
    
    @IBOutlet weak var count: UIStepper!
    @IBOutlet weak var txtSeverity: UILabel!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var reason: UITextField!
    @IBOutlet weak var severity: UIStepper!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[Cry]?
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
      

        

    }
    
    @IBAction func location(_ sender: Any) {
        appDelegate.location = location.text!

    }
    
    @IBAction func reason(_ sender: Any) {
        appDelegate.reason = reason.text!

    }
    @IBAction func when(_ sender: Any) {
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YY/MM/dd"
        appDelegate.date = dateFormatter.string(from: date.date)
        
        

    }
    
    @IBAction func save(_ sender: Any) {
        
        let newCry = Cry(context: self.context)
        newCry.when = appDelegate.date
        newCry.severity = String(severity.value)
        newCry.reason =  appDelegate.reason
        newCry.location = appDelegate.location

        try! self.context.save()
        
    }
    @IBAction func counter(_ sender: Any) {
        txtSeverity.text = String(count.value)
        
    
    }
    
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//     return 1
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // Return the nubmer of people.
//    return self.items?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
//    UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
//    // Get person from array and set the label
//    cell.textLabel?.text = "test"
//    return cell
//    }
    
//    func tableView( tableView: UITableView, did SelectRowAt indexPath: IndexPath) {
//    // Selected Person.
//    let person = self.items![indexPath.row]
//    // Create alert
//    let alert = UIAlertController (title: "Edit Person", message: "Edit name:",
//    preferredStyle: .alert)
//    alert.addTextField()
//    let textfield = alert.textFields! [0]
}




