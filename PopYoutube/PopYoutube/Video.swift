//
//  Video.swift
//  KHS
//
//  Created by Bruno Faganello Neto on 04/01/16.
//  Copyright © 2016 Bruno Faganello Neto. All rights reserved.
//

import UIKit

class Video{
    var title:String!
    var description:String!
    var urlThumbnails:String!
    var thumbnail:UIImage!
    var videoID:String!
    
    func convetUrlToImage(){
        let url = URL(string: urlThumbnails)
        let data = try? Data(contentsOf: url!)
        thumbnail = UIImage(data: data!)
    }
    
    
}
