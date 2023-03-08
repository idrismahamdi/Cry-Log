//
//  Table.swift
//  Cry Log
//
//  Created by Idris Mahamdi on 28/01/2023.
//

import Foundation
import UIKit
import CoreData

class mycell: UITableViewCell {
    @IBOutlet weak var whylbl: UITextView!
    
    @IBOutlet weak var locationlbl: UILabel!
    
    @IBOutlet weak var serveritylbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
}


class tableControl: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var counter: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[Cry]?
    
    var hold: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        fetchCries()
        
        
        
    }
    
    func fetchCries() {
        
        self.items = try! context.fetch(Cry.fetchRequest())
        
        self.tableView.reloadData()
    }
    
    func tableView( tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the nubmer of people
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        counter.text = String(self.items!.count)
        
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as! mycell ?? UITableViewCell(style: .subtitle, reuseIdentifier: "PersonCell") as! mycell
        let cry = self.items?[(items!.count-1)-indexPath.row]
        let when = cry!.when
        var reason = cry!.reason
        var location = cry!.location
        let severity = cry!.severity
        
        if (location == ""){
            location = "Not specifed"
        }
        if (reason == ""){
            reason = "No reason specifed :("
        }
        cell.locationlbl.text = location
        cell.whylbl.text = reason
        cell.serveritylbl.text = severity
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yy"
        
        let date: NSDate? = dateFormatterGet.date(from: when!) as NSDate?
        cell.timelbl.text = dateFormatterPrint.string(from: date! as Date)
        
        //        cell.textLabel?.text = "\(when!) Reason: \(reason ?? "Not given") Where: \(location ?? "Not given") Severity: \(severity ?? "Not given")"
        //        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = .byWordWrapping
        //        cell.lbltest.text = "\(when!) Reason: \(reason ?? "Not given") Where: \(location ?? "Not given") Severity: \(severity ?? "Not given")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let a = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in


            let remove = self.items![(self.items!.count-1) - indexPath.row]

            self.context.delete(remove)
            do{
                try self.context.save()
            }catch{
                
            }
            self.fetchCries()

        }
        a.backgroundColor = UIColor.init(red: 78/255.0, green: 84/255.0, blue: 124/255.0, alpha: 255.0)
        

        return UISwipeActionsConfiguration(actions: [a])

    }
    
    // this method handles row deletio
    
    
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




