//
//  MapViewController.swift
//  MapKit Custom Map Demo
//
//  Created by Nipuna's MacMini on 6/28/17.
//  Copyright © 2017 Nipuna H Herath. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    final func buttonTapped(sender: UIButton){
        print("Clicked: \(sender.tag)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! ButtonCollectionViewCell
        cell.cellButton.setTitle("\(indexPath.row)", for: .normal)
        cell.cellButton.layer.cornerRadius = cell.cellButton.frame.size.height/2
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        return cell
    }
}
