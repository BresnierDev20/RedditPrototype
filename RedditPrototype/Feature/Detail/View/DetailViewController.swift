//
//  DetailViewController.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imagenDetail: UIImageView!
    @IBOutlet weak var imagenDetailAutoLayout: NSLayoutConstraint!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var descriptionDetail: UILabel!
    @IBOutlet weak var profileTitleDetail: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var titleAutoLayout: NSLayoutConstraint!
    
    var detailDt: RedditChild?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailDta(reddit: detailDt)
    }
    
    func detailDta(reddit: RedditChild?) {
        if reddit?.data.media?.oembed?.thumbnail_url != nil {
            imagenDetailAutoLayout.constant = 368
            titleAutoLayout.constant = 22
            descriptionDetail.isHidden = true
            imagenDetail.setImage(urlString: reddit?.data.media?.oembed?.thumbnail_url)
        }else {
            imagenDetailAutoLayout.constant = 1
            titleAutoLayout.constant = 30
            descriptionDetail.isHidden = false
            descriptionDetail.text = reddit?.data.selfText
        }
        
        titleDetail.text = reddit?.data.title
        commentsLabel.text = "Comentario: \(String(describing: reddit?.data.numComments))"
        profileTitleDetail.text = reddit?.data.author
    }

}
