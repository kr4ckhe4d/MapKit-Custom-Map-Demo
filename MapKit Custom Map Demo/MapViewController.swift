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
    
    var selectedOptions = [MapOptionsType]()
    var place = Place(filename: "MagicMountain")
    
    let mapOptionsTypes = ["MapBoundary","MapOverlay","MapPins","MapCharacterLocation","MapRoute"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.45)

        let latDelta = place.overlayTopLeftCoordinate.latitude - place.overlayBottomRightCoordinate.latitude
        
        // Get distance from one corner to the opposite corner.
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        
        let region = MKCoordinateRegionMake(place.midCoordinate, span)
        mapView.region = region

    }
    
    @IBAction func loadOverlay(_ sender: Any) {
//        print("clicked")
        let mapOptionsType = MapOptionsType(rawValue: 1)
        selectedOptions += [mapOptionsType!]
        print(selectedOptions)
        self.loadSelectedOptions()
    }
    
    func loadSelectedOptions() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
//        for option in selectedOptions {
//            switch (option) {
//            case .MapOverlay:
                addOverlay()
//            default:
//                break
//            }
//        }
    }
    
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
    
    func addOverlay(){
        let overlay = PlaceMapOverlay(place: place)
        mapView.add(overlay)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    final func buttonTapped(sender: UIButton){
        print("Clicked: \(sender.tag)")
    }

}

extension MapViewController : UICollectionViewDelegate,UICollectionViewDataSource, MKMapViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapOptionsTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! ButtonCollectionViewCell
        cell.cellButton.setTitle("\(mapOptionsTypes[indexPath.row])", for: .normal)
        cell.cellButton.layer.cornerRadius = cell.cellButton.frame.size.height/2
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let mapOptionsType = MapOptionsType(rawValue: indexPath.row)
        if (cell?.tag == 1) {
            cell!.tag = 0
            // delete object
            selectedOptions = selectedOptions.filter { (currentOption) in currentOption != mapOptionsType}
        } else {
            cell!.tag = 1
            selectedOptions += [mapOptionsType!]
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is PlaceMapOverlay{
            let magicMountainInage = UIImage(named: "overlay_park")
            let overlayView = PlaceMapOverlayView(overlay: overlay, overlayImage: magicMountainInage!)
            
            return overlayView
        }
        return MKOverlayRenderer()
    }
}
