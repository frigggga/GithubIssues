//
//  OpenIssueViewController.swift
//  GithubIssues
//
//  Created by Zhang on 2024/1/23.
//

import UIKit

class OpenIssueViewController: UITableViewController {
    
    let client = GithubClient()
    var openIssues: [GitHubIssue] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Open Issues"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = .red
            
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
        

        let refreshControl = UIRefreshControl()
        let pullTitle = NSAttributedString(string: "Pull to Refresh 🤪")
        refreshControl.attributedTitle = pullTitle
        refreshControl.addTarget(self,
                                 action: #selector(refresh(sender:)),
                                 for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        Task {
            do{
                openIssues = try await client.fetchOpenIssues()
                self.tableView.reloadData()
            } catch {
                print("Request failed with error \(error)")
            }
        }
        

    }
    
    @objc func refresh(sender: UIRefreshControl) {
        print("done refreshing")
        sender.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return openIssues.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = UIColor.systemPink
//        }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        print("Tapped: \(selectedRow)")
        
    }
 


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theIssue = openIssues[indexPath.row]
        let cell: IssueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell", for: indexPath) as! IssueTableViewCell
        cell.openTitle.text = theIssue.title
        cell.openUser.text = "@" + theIssue.user.login
        cell.openImage.image = UIImage(systemName: "bubble.middle.bottom")
        cell.openImage.tintColor = UIColor.red
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDetail" {
            let vc = segue.destination as! IssueDetailViewController
            let row = self.tableView!.indexPathForSelectedRow!.row
            vc.data = self.openIssues[row]
        }

    }


}


