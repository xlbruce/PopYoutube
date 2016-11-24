//
//  WZStoreHouseTableView.swift
//  WZStoreHouseTableView
//
//  Created by z on 15-2-28.
//  Copyright (c) 2015年 SatanWoo. All rights reserved.
//

import UIKit

@objc protocol WZStoreHouseTableViewTransform {
    var miniumScale:CGFloat {get};
    func transformCell(forScale scale:CGFloat);
}

class WZStoreHouseTableView:UITableView {
    override func layoutSubviews() {
        super.layoutSubviews();
        self.transform();
    }
    
    fileprivate func transform()->Void {
       
        for indexPath in self.indexPathsForVisibleRows! as [IndexPath] {
            if let cell = self.cellForRow(at: indexPath) as? WZStoreHouseTableViewTransform {
                let distanceFromCenter = self.computeDistanceFromCenter(indexPath);
                cell.transformCell(forScale: self.computeScale(distanceFromCenter, minScale: cell.miniumScale));
            }
        }
    }
    
    fileprivate func computeDistanceFromCenter(_ indexPath:IndexPath) -> CGFloat {
        let cellRect = self.rectForRow(at: indexPath);
        let cellCenter = cellRect.origin.y + cellRect.size.height/2;
        let contentCenter = self.contentOffset.y + self.bounds.size.height/2;
        
        return fabs(cellCenter - contentCenter);
    }
    
    fileprivate func computeScale(_ distanceFromCenter:CGFloat, minScale:CGFloat)->CGFloat {
        return  (1.0 - minScale) * distanceFromCenter / self.bounds.size.height;
    }
}
