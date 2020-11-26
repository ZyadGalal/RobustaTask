//
//  HomeViewController.swift
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    func registerCell(){
        homeTableView.register(HomeTableViewCell.self)
    }
}

extension HomeViewController: HomeView {
    
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell() as HomeTableViewCell
        cell.repoNameLabel.text = "Zyad Repo"
        cell.ownerNameLabel.text = "Zyad Galal"
        return cell
    }
}
