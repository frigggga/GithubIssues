//
//  Github API.swift
//  GithubIssues
//
//  Created by Zhang on 2024/1/22.
//

import Foundation

class GithubClient{
//
//    static func fetchCloseIssues(completion: @escaping([GithubIssue]?, Error?) -> Void){
//        let url = URL(string: "https://api.github.com/repos/KRTirtho/spotube/issues?state=Closed")!
//        let task = URLSession.shared.dataTask(with: url) {data, _, error in
//            guard let data = data, error == nil else{
//                DispatchQueue.main.async { completion(nil, error)}
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let issues = try decoder.decode([GithubIssue].self, from: data)
//                DispatchQueue.main.async { completion(issues, nil)}
//            } catch (let parsingError){
//                        DispatchQueue.main.async { completion(nil, parsingError)}
//            }
//            
//        }
//        
//        task.resume()
//    }
    func fetchOpenIssues() async throws -> [GitHubIssue]{
        guard let url = URL(string: "https://api.github.com/repos/KRTirtho/spotube/issues?state=open") else {
            throw GitHubFetcherError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
            throw GitHubFetcherError.badResponse
        }
        
        let decode = try JSONDecoder().decode([GitHubIssue].self, from: data)
        return decode
    }
    
    func fetchClosedIssues() async throws -> [GitHubIssue]{
        guard let url = URL(string: "https://api.github.com/repos/KRTirtho/spotube/issues?state=closed") else {
            throw GitHubFetcherError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
            throw GitHubFetcherError.badResponse
        }
        
        let decode = try JSONDecoder().decode([GitHubIssue].self, from: data)
        return decode
    }
}

struct GitHubIssue: Codable, CustomStringConvertible {
    let title: String?
    let created_at: String
    let body: String?
    let state: String
    let user: GitHubUser
    let html_url: String
 

    var description: String {
        return "Issue: title = \(title ?? "N/A"), state = \(state), user = \(user.login)"
    }

}

struct GitHubUser:Codable {
    let login: String
}

enum GitHubFetcherError: Error {
        case invalidURL
        case badResponse
        case decodingError
}
