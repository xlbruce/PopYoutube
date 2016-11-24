//
//  ViewController.swift
//  TecBrasil
//
//  Created by Bruno Faganello Neto on 18/04/16.
//  Copyright © 2016 Bruno Faganello Neto. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    var videos = [Video]()
    var videoSelecionado:Video!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        tableView.tableFooterView = UIView()
        self.loadChannelInformation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ViewControllerTableViewCell;
        let obj = videos[indexPath.row]
        cell.thumbnail.image = obj.thumbnail
        cell.title.text = obj.title
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        videoSelecionado = videos[indexPath.row]
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : DetailsTableViewController = storyboard.instantiateViewController(withIdentifier: "Details") as! DetailsTableViewController
        vc.descirptionString = videoSelecionado.description
        vc.titleString = videoSelecionado.title
        vc.id = videoSelecionado.videoID
        vc.but = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    
    func loadChannelInformation(){
        let y = YoutubeManager()
        y.informaçãoVideo { (videos) in
            self.videos = videos
            self.tableView.reloadData()
        }
    }
}

