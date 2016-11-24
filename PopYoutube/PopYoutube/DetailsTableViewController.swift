//
//  DetailsTableViewController.swift
//  TecBrasil
//
//  Created by Bruno Faganello Neto on 03/05/16.
//  Copyright © 2016 Bruno Faganello Neto. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var videoDescription: UITextView!
    @IBOutlet weak var favButton: UIButton!
    
 
    var descirptionString:String!
    var titleString:String!
    var id:String!
    var but:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        favButton.isEnabled = but!
        tableView.alwaysBounceVertical = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videoTitle.text = titleString
        videoDescription.text = descirptionString
        playerView.load(withVideoId: id)
        self.navigationItem.title = "Detalhes"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        let x = FavoritoManager.sharedInstance.novo()
        x.name = titleString
        x.vDescription = descirptionString
        x.videoID = id
        FavoritoManager.sharedInstance.salvar()
        let alert = UIAlertController(title: "Salvo com Sucesso", message: "Video Salvo", preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        favButton.isEnabled = false
    }

}
