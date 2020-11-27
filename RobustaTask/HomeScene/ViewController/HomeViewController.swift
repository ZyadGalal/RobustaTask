//
//  HomeViewController.swift
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

import UIKit
import Kingfisher
import SVProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    @objc var presenter: HomePresenterImpl?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Repositories"
        registerCell()
        presenter?.viewDidLoad()
    }
    func registerCell(){
        homeTableView.register(HomeTableViewCell.self)
    }
}

extension HomeViewController: HomeView {
    func showIndicator() {
        SVProgressHUD.show(withStatus: "Loading")
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    func didFetchDataSuccessfully() {
        DispatchQueue.main.async {
            self.homeTableView.reloadData()
        }
    }
    
    func didFailFetchingDataWithError(_ error: String!) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: error) { _ in}
        }
    }
    
    
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemsCount = presenter?.repositoriesCount() else {return 0}
        return Int(itemsCount)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter?.getItemAt(Int32(indexPath.row)) else{return UITableViewCell()}
        let cell = tableView.dequeueCell() as HomeTableViewCell
        cell.repoNameLabel.text = model.repoName
        cell.ownerNameLabel.text = model.ownerName
        cell.avatarImageView.kf.indicatorType = .activity
        cell.avatarImageView.kf.setImage(with: model.ownerAvatarURL)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRepo(at: Int32(indexPath.row))
    }
}
