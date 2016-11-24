//
//  FavoritosTableViewController.swift
//  PopYoutube
//
//  Created by Bruno Faganello Neto on 16/11/16.
//  Copyright © 2016 Bruno Faganello Neto. All rights reserved.
//

import UIKit

class FavoritosTableViewController: UITableViewController {
    var videos = [Favorito]()
    var videoSelecionado:Favorito!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadChannelInformation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        let index = videos.count
        let label = UILabel(frame: view.frame)
        if(index == 0){
            label.text = "Nenhum Favorito Adicionado"
            label.textColor = UIColor.black
            label.textAlignment = NSTextAlignment.center
            label.center = view.center
        }
        else{
            label.text = ""
            
        }
        self.tableView.backgroundView = label
        
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoritoTableViewCell;
        let obj = videos[indexPath.row]
        cell.title.text = obj.name
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        videoSelecionado = videos[indexPath.row]
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : DetailsTableViewController = storyboard.instantiateViewController(withIdentifier: "Details") as! DetailsTableViewController
        vc.descirptionString = videoSelecionado.vDescription
        vc.titleString = videoSelecionado.name
        vc.id = videoSelecionado.videoID
        vc.but = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {}
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Deletar") { (action, indexPath) -> Void in
            let videoSelecionado = self.videos[(indexPath as NSIndexPath).row]
            if FavoritoManager.sharedInstance.apagar(videoSelecionado) {
                self.videos.remove(at: (indexPath as NSIndexPath).row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
                
            }
        }
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    
    func loadChannelInformation(){
        let f = FavoritoManager.sharedInstance.buscar()
        videos = f
        self.tableView.reloadData()
    }
}
