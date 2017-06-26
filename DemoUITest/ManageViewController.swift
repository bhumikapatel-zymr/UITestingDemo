//
//  ViewController.swift
//  DemoUITest
//
//  Created by Bhumika Patel on 22/06/17.
//  Copyright © 2017 Bhumika Patel. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ManageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var TeamData : NSManagedObject!
    
    @IBOutlet weak var tblData:UITableView!
    
    var result: Array<AnyObject> = []
    var resultAddress: Array<AnyObject> = []
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!




    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        // fetch data for USER entity
        
        self.navigationItem.hidesBackButton =  false

        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TeamRecord")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        do {
            result = try appDelegate.managedObjectContext.fetch(fetchRequest) as Array<AnyObject>
            
            if ((result.count) > 0) {
                
                self.tblData.reloadData()
            }
            else
            {
                // self.alert(message: "No Data found")
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Tablewview datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    //MARK: Tablewview  delegates methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        TeamData = result[indexPath.row] as! NSManagedObject
        
        
        let str = TeamData.value(forKey: "name") as? String
        cell.lblName?.text = str
        
        cell.lblcountry?.text = TeamData.value(forKey: "country") as? String

        cell.lblDept?.text = TeamData.value(forKey: "Department") as? String

    
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            
            context.delete(result[indexPath.row] as! NSManagedObject)
            result.remove(at: indexPath.row)
            
            let _ : NSError! = nil
            do {
                try context.save()
                self.tblData.reloadData()
            } catch {
                print("error : \(error)")
            }
        }
        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    

}

