//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Athena Enosara on 2/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var tweetUser: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    var favorited: Bool = false
    var tweetID: Int = -1
    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func favTweet(tweetId: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        let url = "https://api.twitter.com/1.1/favorites/create.json"
        
        TwitterAPICaller.client?.postRequest(url: url, parameters: ["id",tweetId], success: {
            () in success()
        }, failure: { (Error) in
            failure(Error)
        })
    }
    
    
    func unfavTweet(tweetID: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        let url = "https://api.twitter.com/1.1/favorites/destroy.json"
        
        TwitterAPICaller.client?.postRequest(url: url, parameters: ["id",tweetID], success: {
            () in success()
        }, failure: { (Error) in
            failure(Error)
        })
    }
    
    
    @IBAction func favTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if(toBeFavorited) {
            TwitterAPICaller.client?.favTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
