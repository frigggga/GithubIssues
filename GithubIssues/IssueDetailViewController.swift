//
//  IssueDetailViewController.swift
//  GithubIssues
//
//  Created by Zhang on 2024/1/23.
//

import UIKit

class IssueDetailViewController: UIViewController {
    
    var data: GitHubIssue?
    
  
 
    @IBAction func safari(_ sender: Any) {
        guard let safariURL = URL(string: data!.html_url) else { return  }
        print(safariURL)
        UIApplication.shared.open(safariURL)
    }
    
    @IBOutlet weak var issueText: UITextView!
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueName: UILabel!
    @IBOutlet weak var issueDate: UILabel!
    @IBOutlet weak var issueImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let datformatter = DateFormatter()
        datformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = datformatter.date(from: data!.created_at)
        let formattedDate = date!.getFormattedDate(format: "MMM dd, yyyy")
    
        issueText.text = data!.body
        issueTitle.text = data!.title
        issueName.text = "@" + data!.user.login
        issueDate.text = formattedDate
        
        let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = .red
            
        if data!.state == "open" {
            issueImage.image = UIImage(systemName: "bubble.middle.bottom")
            barAppearance.backgroundColor = .red
            issueImage.tintColor = UIColor.red
        }else{
            issueImage.image = UIImage(systemName: "xmark.circle")
            issueImage.tintColor = UIColor.green
            barAppearance.backgroundColor = .green
        }
        
        navigationItem.standardAppearance = barAppearance
        navigationItem.scrollEdgeAppearance = barAppearance
        
        
    }
    
    
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
