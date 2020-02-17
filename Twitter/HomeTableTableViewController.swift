//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Athena Enosara on 2/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    // var numberOfTweets = Int?.self // gave an error
    var numberOfTweets = Int?.self
    
    func loadTweet(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": 10]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
        }, failure: { (Error) in
            print("Could not retireve tweets.")
        })
    }
    
    // START LOG OUT CODE
    @IBAction func on_logoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(false, forKey: "UserLoggedIn")
    }// END LOG OUT CODE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
//        "profile_image_url_https": "https://pbs.twimg.com/profile_images/942858479592554497/BbazLO9L_normal.jpg",
        
        
        cell.tweetUser.text = user["name"] as? String
        cell.tweetContent.text = (tweetArray[indexPath.row]["text"] as! String)
        
        let imageUrl = URL(string: (user["profile_image_url_https"])! as! String)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.tweetImage.image = UIImage(data: imageData)
        }
        
        
        return cell
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

}
