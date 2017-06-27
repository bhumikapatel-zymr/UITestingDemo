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

class AddViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var txtfieldTName: UITextField!
    @IBOutlet weak var txtfieldTDept:UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var txtfieldTCOuntry: UITextField!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    var TeamObj : NSManagedObject!
    var strCountry : String! = "INDIA"
    var currentValue: Int!

    var muteForPickerData = ["INDIA", "USA", "CHINA" ,"LONDON", "PAKISTAN"]




    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton =  false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Buttons action methods
    
    @IBAction func sliderValueChanged(sender: UISlider) {
         currentValue = Int(sender.value)
        print("Slider changing to \(currentValue) ?")
        lblSize.text = "\(currentValue!) Team Size"
    }

    @IBAction func btnSubmitPressed()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let entity = NSEntityDescription.entity(forEntityName: "TeamRecord", in: appDelegate.managedObjectContext) {
            // Create Managed Object
            TeamObj = NSManagedObject(entity: entity, insertInto:appDelegate.managedObjectContext)
            
            // Populate Managed Object
            TeamObj.setValue(txtfieldTName.text, forKey: "Name")
            TeamObj.setValue(txtfieldTDept.text, forKey: "Department")
            TeamObj.setValue(currentValue, forKey: "size")
            TeamObj.setValue(strCountry, forKey: "Country")

            
            do {
                try TeamObj.managedObjectContext?.save()
                self.alert(message:"Successfully Done" , title:"Great!" )

            } catch {
                
                self.alert(message: "Oops! Some error occured")
                
            }
            
        }
    }
    
    @IBAction func btnAddPickerPressed()
    {
    let vc = UIViewController()
    vc.preferredContentSize = CGSize(width: 250,height: 300)
    let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    pickerView.delegate = self
    pickerView.dataSource = self

    vc.view.addSubview(pickerView)
    let editRadiusAlert = UIAlertController(title: "Choose distance", message: "", preferredStyle: UIAlertControllerStyle.alert)
    editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler:  { action -> Void in

            self.txtfieldTCOuntry.text = self.strCountry
        }))
    editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(editRadiusAlert, animated: true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return muteForPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return muteForPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        strCountry = muteForPickerData[row]
        
    }
    


}

