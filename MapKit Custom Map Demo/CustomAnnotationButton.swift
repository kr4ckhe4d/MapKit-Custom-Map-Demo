//
//  CustomAnnotationButton.swift
//  MapKit Custom Map Demo
//
//  Created by Nipuna's MacMini on 6/29/17.
//  Copyright © 2017 Nipuna H Herath. All rights reserved.
//

import UIKit

class CustomAnnotationButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    func setSelected() {
        backgroundColor = UIColor.gray
    }
    func deselect() {
        backgroundColor = UIColor.clear
    }
    

    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.gray : .clear
        }
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        backgroundColor = UIColor.gray
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        backgroundColor = UIColor.clear
    }

}
