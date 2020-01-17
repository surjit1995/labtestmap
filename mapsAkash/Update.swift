

import Foundation
import UIKit
import CoreData


class Update:UIViewController
{
    var locArray = Location()
    var delte = ViewController()
    @IBOutlet weak var updateTitle: UITextField!
    @IBOutlet weak var updateSub: UITextField!
    @IBOutlet weak var updateLati: UITextField!
    @IBOutlet weak var updateLongi: UITextField!
    @IBAction func updateBtn(_ sender: Any)
    {
        self.updateRecord(location: locaton, title: updateTitle.text!, subTitle: updateSub.text!, latitude: Double(updateLati.text!)!, longitude: Double(updateLongi.text!)!)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    var locaton = Location()
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
      
       
      deleteRecord(person: locaton)
        
    }
    func deleteRecord( person : Location){
          ViewController.managedContext.delete(person)
          try! ViewController.managedContext.save()
      }
    override func viewDidLoad() {
          super.viewDidLoad()
          updateTitle.text = locaton.mapTitle
            updateSub.text = locaton.mapSubTitle?.description
          updateLati.text = locaton.mapLatutude.description
          updateLongi.text = locaton.mapLongitude.description
      }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
          
       //    MyViewController.managedContext = coreDataStack.managedContext
           
           
       }
    
    func updateRecord(location:Location,title:String,subTitle:String,latitude: Double,longitude: Double){
              
              
                  location.mapTitle = title
                  location.mapSubTitle = subTitle
                  location.mapLatutude = latitude
                  location.mapLongitude = longitude
            try! ViewController.managedContext.save()
          }
    

}
