//
//  HomeTableViewCell.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 5/4/24.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imagenView: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subreddit: UILabel!
    @IBOutlet weak var subredditDescription: UILabel!
    @IBOutlet weak var comments: UILabel!
    
    static let reuseIdentifier = "HomeViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 3
    }
    
    func configUI(response: RedditChild) {
        let maxCharacters = 100
        
          let description = response.data.title
          if description.count > maxCharacters {
              title.text = String(description.prefix(maxCharacters)) + "..."
          } else {
              title.text = description
          }
        author.text = response.data.author
        comments.text =  "\(response.data.numComments)"
        subredditDescription.text = "\(response.data.subreddit)"
        
        if response.data.media?.oembed?.thumbnail_url  != nil {
            imagenView.isHidden = false
            imagenView.setImage(urlString: response.data.media?.oembed?.thumbnail_url)
          
        }else {
            imagenView.isHidden = true
        }
    }
}
