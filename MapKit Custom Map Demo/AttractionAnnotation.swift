//
//  AttractionAnnotation.swift
//  MapKit Custom Map Demo
//
//  Created by Nipuna's MacMini on 7/3/17.
//  Copyright © 2017 Nipuna H Herath. All rights reserved.
//

import Foundation
import MapKit


enum AttractionType: Int{
    case AttractionDefault = 0
    case AttractionFirstAid
    case AttractionFood
    case AttractionRide
}
class AttractionAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: AttractionType
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: AttractionType) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}
