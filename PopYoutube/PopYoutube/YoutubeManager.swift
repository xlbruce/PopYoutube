//
//  YoutubeManager.swift
//  TecBrasil
//
//  Created by Bruno Faganello Neto on 20/12/15.
//  Copyright © 2015 Bruno Faganello Neto. All rights reserved.
//

import UIKit

class YoutubeManager{
    fileprivate let apiKey = "AIzaSyBqhziXZcnCKfrZ4yaHBM3YdzNj5gmKGRU"
    
     func informaçãoVideo(completionHandler:@escaping ([Video])->()){
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () -> Void in
            
            let youtubeApi = "https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&maxResults=10&key=\(self.apiKey)"
            let url: URL = URL(string: youtubeApi)!
            // Create your request
            let request: URLRequest = URLRequest(url: url)
            let queue:OperationQueue = OperationQueue()
            var response: URLResponse?
            do{
                let data = try NSURLConnection.sendSynchronousRequest(request, returning: &response)
                var videos = [Video]()
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                print(json)
                
                let items = json["items"]!
                for i in 0 ... 9{
                    let firsItemDict = (items as! Array<AnyObject>)[i] as! Dictionary<String, Any>
                    let videoID = firsItemDict["id"] as! String
                    let snippetDict = firsItemDict["snippet"] as! Dictionary<String, Any>
                    
                    let title = snippetDict["title"]! as! String
                    let description = snippetDict["description"]! as! String
                    
                    let thumb = snippetDict["thumbnails"] as! Dictionary<String, Any>
                    let standard = thumb["high"] as! Dictionary<String, Any>
                    let url = standard["url"]! as! String
                    
                    
                    
                    
                    let v = Video()
                    v.title = title
                    v.videoID = videoID
                    v.description = description
                    v.urlThumbnails = url
                    v.convetUrlToImage()
                    videos.append(v)
                }
                
                var erro:NSError?
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(videos)
                })
                return
                
            } catch(let e as NSError){
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler([Video]())
                })
                return
            }
        
        })
    }

}
