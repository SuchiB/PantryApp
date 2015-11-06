//
//  ViewController.swift
//  MyApp
//
//  Created by Shiva Narrthine on 6/6/14.
//  Copyright (c) 2014 Shiva Narrthine. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMobileAds

class AddToDoViewController: UIViewController, CLLocationManagerDelegate {

    
    
    @IBOutlet weak var BannerView1: GADBannerView!
    @IBOutlet weak var BannerView2: UIView!
    @IBOutlet weak var BannerView3: GADBannerView!
    class ViewController: UIViewController {
        
        @IBOutlet var bannerView: GADBannerView!
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            bannerView.loadRequest(GADRequest())
        }
    }

    

    
    
    var toDoItem: ToDoItem?
    let locationManager = CLLocationManager()
    
    @IBOutlet var textfield : UITextField!
    @IBOutlet var doneButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        // Ask for Authorisation from the User.
        self.locationManager.requestWhenInUseAuthorization()
        //self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as? NSObject == self.doneButton{
            if !self.textfield.text!.isEmpty{
                self.toDoItem = ToDoItem(name: self.textfield.text!)
            }
            return
        }
       
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//    {
//        
//        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
//            
//            if (error != nil) {
//                print("Error:" + error!.localizedDescription)
//                
//                return
//            }
//            
//            if placemarks!.count > 0
//            {
//                if let pm = placemarks?.first {
//                    self.displayLocationInfo(pm)
//                }
//                print(placemarks!.count)
//  
//            }else {
//                
//                print("Error with data")
//                
//            }
//            
//        })
//    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        
    {
        
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        
                CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
        
                    if (error != nil) {
                        print("Error:" + error!.localizedDescription)
        
                        return
                    }
        
                    if placemarks!.count > 0
                    {
                        if let pm = placemarks?.first {
                            self.displayLocationInfo(pm)
                        }
                        print(placemarks!.count)
        
                    }else {
                        
                        print("Error with data")
                        
                    }
                    
               })
        
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
    
        self.locationManager.stopUpdatingLocation()
        print("Stop Location Search")
 
        print(placemark.locality)
        
        print(placemark.postalCode)
        
        print(placemark.administrativeArea)
        
        print(placemark.country)
        
     
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print("Error: " + error.localizedDescription)
        
    }

    @IBAction func findMyLocation(sender: UIButton) {
        print("findMylocation Pressed")
        self.locationManager.startUpdatingLocation()
    }
        
    
}

