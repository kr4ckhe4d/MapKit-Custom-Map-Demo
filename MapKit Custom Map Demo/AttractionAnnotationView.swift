//
//  AttractionAnnotationView.swift
//  MapKit Custom Map Demo
//
//  Created by Nipuna's MacMini on 7/3/17.
//  Copyright © 2017 Nipuna H Herath. All rights reserved.
//

import Foundation
import MapKit

class AttractionAnnotationView: MKAnnotationView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let attractionAnnotation = self.annotation as! AttractionAnnotation
        switch (attractionAnnotation.type) {
        case .AttractionFirstAid:
            image = UIImage(named: "firstaid")
        case .AttractionFood:
            image = UIImage(named: "food")
        case .AttractionRide:
            image = UIImage(named: "ride")
        default:
            image = UIImage(named: "star")
        }
    }
}
