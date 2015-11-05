//
//  MapViewController.swift
//  HoboApp
//
//  Created by WLD_MBP_20 on 05/11/2015.
//  Copyright © 2015 probert. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self;
        mapView.showsUserLocation = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ---------- MGLMapView Delegate
    
    func mapView(mapView: MGLMapView, didUpdateUserLocation userLocation: MGLUserLocation?) {
        
        print(userLocation?.description)
        mapView.setCenterCoordinate(userLocation!.location!.coordinate, zoomLevel: 10, animated: true)
    }
}
