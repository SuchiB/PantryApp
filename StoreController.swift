//
//  StoreControllerViewController.swift/Users/040916399/Documents/ThePantry/PantryApp/MyApp/Main.storyboard
//  Pantry
//
//  Created by 040916399 on 19/11/2015.
//  Copyright © 2015 Shiva Narrthine. All rights reserved.
//

import UIKit
import MapKit

class StoreController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nextPage: UIBarButtonItem!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var swiftBlogs: [String] = []

    
    @IBOutlet weak var nextPages: UIButton!
    @IBOutlet weak var storeTableView: UITableView!
    
    
    @IBAction func nextView(sender: AnyObject) {
    }
    
    
    @IBAction func searchText(sender: AnyObject) {
        sender.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch()
    }
    let textCellIdentifier = "cell"
    var lat = 0.0;
    var long = 0.0;
   
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        storeTableView.delegate = self
        storeTableView.dataSource = self
        checkLocationAuthorizationStatus()
        
        
        
           }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            //this is the place where you get the new location
            lat  = location.coordinate.latitude
            print("\(location.coordinate.latitude)")
            long  = location.coordinate.longitude
            print("\(location.coordinate.longitude)")
            
            let initialLocation = CLLocation(latitude: lat, longitude: long)
            centerMapOnLocation(initialLocation)
            
            
        }
       

    }
    
    let regionRadius: CLLocationDistance = 800
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "coles"
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
         search.startWithCompletionHandler({(response: MKLocalSearchResponse?, error: NSError?) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    self.swiftBlogs.append(item.name!)
                    self.storeTableView.reloadData()
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }

    
  
    func numberOfSectionsInTableView(storeTableView: UITableView) -> Int {
        return 1
    }
    
   
    
    func tableView(storeTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftBlogs.count
    }
    
    
    
    
    func tableView(storeTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = storeTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = swiftBlogs[row]
        
        return cell
    }
    
     func tableView(storeTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        print(swiftBlogs[row])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
