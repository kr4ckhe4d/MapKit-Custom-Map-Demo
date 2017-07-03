//
//  MapViewController.swift
//  MapKit Custom Map Demo
//
//  Created by Nipuna's MacMini on 6/28/17.
//  Copyright © 2017 Nipuna H Herath. All rights reserved.
//

import UIKit
import MapKit

enum MapOptionsType: Int {
    case MapBoundary = 0
    case MapOverlay
    case MapPins
    case MapCharacterLocation
    case MapRoute
}

enum MapType: Int {
    case standard = 0
    case hybrid
    case satellite
}

class MapViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    var currentlySelectedAnnotationIndex: Int = -1
    
    
    // Retrieve custom map latitude/ longitude info from the .plist file.
    var place = Place(filename: "MagicMountain")
    
    // Bottom bar button annotation types. These will be retrieved from backend.
    let annotationOptionsTypes = ["first-aid","foods","info","toilet","shop","stage","lost","first-aid","foods","info","toilet","shop","stage","lost"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.65)

        let latDelta = place.overlayTopLeftCoordinate.latitude - place.overlayBottomRightCoordinate.latitude
        // Get distance from one corner to the opposite corner(Diagonal distance).
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        let region = MKCoordinateRegionMake(place.midCoordinate, span)
        mapView.region = region // Focus the map to the custom map area when the map is loaded.
    }
    
    // MARK - addOverlay
    func addOverlay(){
        // Remove any existing annotations/ overlays to prevent duplicates.
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        let overlay = PlaceMapOverlay(place: place)
        mapView.add(overlay)
    }
    
    func addAttractionPins(annotationType: Int) {
        let filePath = Bundle.main.path(forResource: "MagicMountainAttractions", ofType: "plist")
        var attractions = [NSDictionary]()
        let attractions1 = NSArray(contentsOfFile: filePath!)
        
        for attraction in attractions1! {
            attractions.append(attraction as! NSDictionary)
        }
        
        for attraction in attractions {
            let typeRawValue = Int((attraction["type"] as! String))
            
            if (typeRawValue == annotationType) {
                let point = CGPointFromString(attraction["location"] as! String)
                let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
                let title = attraction["name"] as! String
                
                let type = AttractionType(rawValue: typeRawValue!)!
                let subtitle = attraction["subtitle"] as! String
                let annotation = AttractionAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
                
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    // MARK - Button Actions
    @IBAction func loadOverlay(_ sender: Any) {
        let button = sender as! UIButton
        if (button.tag == 0){
            button.tag = 1
            addOverlay()
            button.setTitle("Hide Map", for: .normal)
        }else{
            button.tag = 0
            mapView.removeAnnotations(mapView.annotations)
            mapView.removeOverlays(mapView.overlays)
            button.setTitle("Show Map", for: .normal)
        }

    }
    
    // Switch map layout types to hybrid, satellite and standard
    @IBAction func mapTypeChanged(_ sender: AnyObject) {
        let mapType = mapView.mapType
        switch (mapType) {
        case .standard:
            mapView.mapType = .hybrid
        case .hybrid:
            mapView.mapType = .satellite
        case .satellite:
            mapView.mapType = .standard
        default:
            mapView.mapType = .standard
        }
    }
    
    final func buttonTapped(sender: UIButton){
        // Remove any existing annotations/ overlays to prevent duplicates.
        mapView.removeAnnotations(mapView.annotations)
        
        if (currentlySelectedAnnotationIndex >= 0){
            let indexPath = IndexPath(row: currentlySelectedAnnotationIndex, section: 0)
            let cell = collectionView.cellForItem(at: indexPath) as! ButtonCollectionViewCell
            let button = cell.cellButton as! CustomAnnotationButton
            button.deselect()
        }
        
        print("Clicked: \(sender.tag)")
        let button = sender as! CustomAnnotationButton
        print(button.isChosen)
        if (button.isChosen == true) {
            button.deselect()
        }else{
            button.setSelected()
            currentlySelectedAnnotationIndex = sender.tag
            addAttractionPins(annotationType: sender.tag + 1)
        }
    }
}


// MARK - Delegate Implementation
extension MapViewController : UICollectionViewDelegate,UICollectionViewDataSource, MKMapViewDelegate{
    // MARK - CollectionView Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annotationOptionsTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! ButtonCollectionViewCell
        cell.cellButton.setImage(UIImage(named: annotationOptionsTypes[indexPath.row]), for: .normal)
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    // MARK - Map View Delegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is PlaceMapOverlay{
            let magicMountainInage = UIImage(named: "overlay_park")
            let overlayView = PlaceMapOverlayView(overlay: overlay, overlayImage: magicMountainInage!)
            
            return overlayView
        }
        return MKOverlayRenderer()
    }
    
    // Annotations Delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = AttractionAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
        annotationView.canShowCallout = true
        return annotationView
    }
}
