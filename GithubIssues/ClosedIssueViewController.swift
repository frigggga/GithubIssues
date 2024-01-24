//
//  ClosedIssueViewController.swift
//  GithubIssues
//
//  Created by Zhang on 2024/1/23.
//

import UIKit

class ClosedIssueViewController: UITableViewController {
    
    let client = GithubClient()
    var closedIssues: [GitHubIssue] = []
    
    override func viewDidLoad() {
        
        title = "Closed Issues"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = .green
            
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
        
        let refreshControl = UIRefreshControl()
        let title = NSAttributedString(string: "Pull to Refresh 🤪")
        refreshControl.attributedTitle = title
        refreshControl.addTarget(self,
                                 action: #selector(refresh(sender:)),
                                 for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        Task {
            do{
                closedIssues = try await client.fetchClosedIssues()
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
        return closedIssues.count
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
        let cell: IssueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell", for: indexPath) as! IssueTableViewCell
        let theIssue = closedIssues[indexPath.row]
        cell.closedTitle.text = theIssue.title
        cell.closedUser.text =  "@" + theIssue.user.login
        cell.closedImage.image = UIImage(systemName: "xmark.circle")
        cell.closedImage.tintColor = UIColor.green
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "closedDetail" {
            let vc = segue.destination as! IssueDetailViewController
            let row = self.tableView!.indexPathForSelectedRow!.row
            vc.data = self.closedIssues[row]
        }

    }
    
}

