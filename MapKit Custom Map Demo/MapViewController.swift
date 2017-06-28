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

class MapViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    let mapOptionsTypes = ["MapBoundary","MapOverlay","MapPins","MapCharacterLocation","MapRoute"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.45)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    final func buttonTapped(sender: UIButton){
        print("Clicked: \(sender.tag)")
    }

}

extension MapViewController : UICollectionViewDelegate,UICollectionViewDataSource{
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
}
