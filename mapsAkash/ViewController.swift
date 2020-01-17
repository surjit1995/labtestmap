
import UIKit
import CoreData
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    
    static  var managedContext: NSManagedObjectContext!
    
    //pins dkhuan lai
    var selectPin: MKAnnotation!
    //modal class di entity
    var locatonSingle = Location()
//model class di entity da array
    var locDataArray = [Location]()

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func addBtn(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Edit") as? Edit {
        
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setPins()
    }
    
    func setPins() {   // pins show krda map te
        
        var locValue:CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        print("latitude" + "\(locValue.latitude)")
        print("latitude" + "\(locValue.longitude)")
        
        
        var pinPoint = [MKPointAnnotation]()
        
        locDataArray = fetchRecords()
           mapView.removeAnnotations(mapView.annotations)
        for i in 0..<locDataArray.count{
            let annotation = MKPointAnnotation()
            
         locValue.latitude = locDataArray[i].mapLatutude
            locValue.longitude = locDataArray[i].mapLongitude
            
            annotation.coordinate = locValue
            mapView.isZoomEnabled = true
            
            
            annotation.title = locDataArray[i].mapTitle
            annotation.subtitle = locDataArray[i].mapSubTitle?.description
            
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            
            pinPoint.append(annotation)
            //  mapView.addAnnotation(annotation)
        }
        mapView.addAnnotations(pinPoint)
        
        let loca = CLLocationCoordinate2DMake(locValue.latitude,
                                              locValue.longitude)
        let coordinateRegion = MKCoordinateRegion(center: loca,
                                                  latitudinalMeters: 4000000, longitudinalMeters: 4000000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
   
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {  // pin nu select krn to bad jo annotation show hundi a 
       
           
           selectPin = view.annotation
        // print("Selected 222 == \(view.annotation?.title ?? default value)")
       }
       // Map Functions To get the location for the user
       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           
          // selectPinView = annotation
           
          // print("Selected == \(selectPinView.title)")
           if !(annotation is MKUserLocation) {
               
               let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))

               
               let rightButton = UIButton(type: .infoDark)
               rightButton.tag = annotation.hash
               rightButton.addTarget(self, action: #selector(annoBtnPressed), for: .touchDown)
               pinView.animatesDrop = true
               pinView.canShowCallout = true
               pinView.rightCalloutAccessoryView = rightButton
               
               
               return pinView
           }
           else {
               return nil
           }
       }
       
       @objc func annoBtnPressed(){   // function call hunda jdo (i) nu clik krde a 
           self.view.layoutIfNeeded()
           
           if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Update") as? Update {
                      
                      
                      for i in 0..<self.locDataArray.count{
                          if(self.locDataArray[i].mapSubTitle ==  ((selectPin?.subtitle)!)!) {  //compares sub title to select that information
                              self.locatonSingle = self.locDataArray[i]
                              break
                          }}
            
                      viewController.locaton = self.locatonSingle
                      
                      if let navigator1 = self.navigationController {
                          navigator1.pushViewController(viewController, animated: true)
                      }
     
           }
           
       }


          func fetchRecords() -> [Location]{
             var arrLocation = [Location]()
             let fetchRequest = NSFetchRequest<Location>(entityName: "Location")
             
                 do{
                   arrLocation = try ViewController.managedContext.fetch(fetchRequest)
                 }catch{
                     print(error)
                 }
                 return arrLocation
             }

//             func deleteRecord( location : Location){
//               ViewController.managedContext.delete(location)
//               try! ViewController.managedContext.save()
//             }
//
         
    

}

