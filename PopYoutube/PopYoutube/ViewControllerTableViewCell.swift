//
//  ViewControllerTableViewCell.swift
//  TecBrasil
//
//  Created by Bruno Faganello Neto on 02/05/16.
//  Copyright © 2016 Bruno Faganello Neto. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell, WZStoreHouseTableViewTransform {
    @IBOutlet weak var scaleView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    
    let miniumScale:CGFloat = 0.85;
    override func prepareForReuse() {
        super.prepareForReuse();
        self.scaleView.transform = CGAffineTransform(scaleX: self.miniumScale, y: self.miniumScale);
    }
    
    func transformCell(forScale scale: CGFloat) {
        self.scaleView.transform = CGAffineTransform(scaleX: 1.0 - scale, y: 1.0 - scale);
    }
}
