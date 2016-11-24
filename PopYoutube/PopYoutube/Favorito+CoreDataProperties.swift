//
//  Favorito+CoreDataProperties.swift
//  PopYoutube
//
//  Created by Bruno Faganello Neto on 16/11/16.
//  Copyright © 2016 Bruno Faganello Neto. All rights reserved.
//

import Foundation
import CoreData


extension Favorito {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorito> {
        return NSFetchRequest<Favorito>(entityName: "Favorito");
    }

    @NSManaged public var name: String?
    @NSManaged public var vDescription: String?
    @NSManaged public var videoID: String?

}
