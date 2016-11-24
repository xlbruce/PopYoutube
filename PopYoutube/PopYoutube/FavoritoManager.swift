//
//  FavoritoManager.swift
//  PopYoutube
//
//  Created by Bruno Faganello Neto on 16/11/16.
//  Copyright © 2016 Bruno Faganello Neto. All rights reserved.
//

import Foundation
import CoreData
import UIKit


open class FavoritoManager{
    static let sharedInstance:FavoritoManager = FavoritoManager()
    static let entityName:String = "Favorito"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    fileprivate init(){}
    
    func novo()->Favorito
    {
        return NSEntityDescription.insertNewObject(forEntityName: FavoritoManager.entityName, into: managedContext) as! Favorito
    }
    
    func salvar()
    {
        var error:NSError?
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Erro ao salvar. Error: \(error), \(error!.userInfo)")
        }
        
        
    }
    
    func buscar()->Array<Favorito>
    {
        let fetchRequest:NSFetchRequest<Favorito> = NSFetchRequest(entityName: FavoritoManager.entityName)
        do{
            let fetchedResults = try managedContext.fetch(fetchRequest)
            
            let results = fetchedResults
            return results
            
        }
        catch let erro as NSError{
            print("Erro ao buscar as Series erro: \(erro), \(erro.userInfo)")
        }
        
        return Array<Favorito>()
    }
    
    func apagar(_ sr:Favorito) -> Bool
    {
        var error:NSError?
        managedContext.delete(sr)
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Erro ao tentar remover: \(error)")
        }
        return true
    }
    
}
