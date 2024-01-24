//
//  IssueTableViewCell.swift
//  GithubIssues
//
//  Created by Zhang on 2024/1/23.
//

import UIKit

class IssueTableViewCell: UITableViewCell {
    

    @IBOutlet weak var openImage: UIImageView!
    @IBOutlet weak var openUser: UILabel!
    @IBOutlet weak var openTitle: UILabel!
    
    @IBOutlet weak var closedImage: UIImageView!
    @IBOutlet weak var closedUser: UILabel!
    @IBOutlet weak var closedTitle: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
