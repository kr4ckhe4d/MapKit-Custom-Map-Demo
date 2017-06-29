//
//  Overlay.swift
//  MapKit Custom Map Demo
//
//  A MKOverlay is how you tell MapKit where you want the overlays drawn.
//
//  Created by Nipuna's MacMini on 6/27/17.
//  Copyright © 2017 Nipuna H Herath. All rights reserved.
//

import Foundation
import MapKit

class PlaceMapOverlay: NSObject, MKOverlay {
    var coordinate = CLLocationCoordinate2D()
    var boundingMapRect = MKMapRect()
    
    init(place: Place) {
        boundingMapRect = place.overlayBoundingMapRect
        coordinate = place.midCoordinate
    }
    
}
