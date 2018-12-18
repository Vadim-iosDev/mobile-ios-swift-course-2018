//
//  SearchViewController.swift
//  MA-github-client
//
//  Created by Dan on 12/17/18.
//  Copyright © 2018 Dan Viitenko. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    var repositories = [Repo]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
    var dataFiltered: [Repo]!
    override func viewDidLoad() {
        super.viewDidLoad()
        addRepo()
        let nib = UINib.init(nibName: "RepoTableViewCell", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "RepoTableViewCell")
        searchBar.delegate = self
        dataFiltered = repositories
        tblView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFiltered.count
    }
    func addRepo(){
        let repo1 = Repo(title: "Disk", subtitle:"Forked from saoudrizwan/Disk", description:"Delightful framework for iOS to easily persist structs, images, and data", language: "Swift")
        let repo2 = Repo(title: "RxSwift", subtitle:"Forked from ReactiveX/RxSwift", description:"Reactive Programming in Swift", language: "Swift")
        let repo3 = Repo(title: "ios-mvp-clean-architecture", subtitle:"Forked from FortechRomania/ios-mvp-clean-architecture", description:"Demo iOS application built to highlight MVP (Model View Presenter) and Clean Architecture concepts", language: "Swift")
        
        repositories += [repo1,repo2,repo3]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        let hedline = dataFiltered[indexPath.row]
        cell.titleLabel.text = hedline.title
        cell.subtitleLabel.text = hedline.subtitle
        cell.descriptionLabel.text = hedline.description
        cell.languageLabel.text = hedline.language
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataFiltered = searchText.isEmpty ? repositories : repositories.filter({(dataString: Repo) -> Bool in
            dataString.title.range(of: searchText, options: .caseInsensitive) != nil
        } )
        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowRepoSearch", sender: nil)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRepoSearch"{
            if let indexPath = tblView.indexPathForSelectedRow{
                let detailVC = segue.destination as! DetailSearchViewController
                detailVC.repo = [self.repositories[indexPath.row]]
            }
        }
    }
}
