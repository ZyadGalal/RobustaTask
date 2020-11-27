//
//  ContributorsViewController.swift
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

import UIKit
import Kingfisher
import SVProgressHUD

class ContributorsViewController: UIViewController {

    @IBOutlet weak var contributorsTableView: UITableView!
    @objc var presenter: ContributorsPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contributors"
        registerCell()
        presenter?.viewDidLoad()
    }
    func registerCell(){
        contributorsTableView.register(ContributorsTableViewCell.self)
    }
}
extension ContributorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemsCount = presenter?.repositoriesCount() else {return 0}
        return Int(itemsCount)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter?.getItemAt(Int32(indexPath.row)) else{return UITableViewCell()}
        let cell = tableView.dequeueCell() as ContributorsTableViewCell
        cell.contributorNameLabel.text = model.contributorName
        cell.contributorImageView.kf.indicatorType = .activity
        cell.contributorImageView.kf.setImage(with: model.contributorAvatarURL)
        
        return cell
    }
}
extension ContributorsViewController: ContributorsView {
    func didFetchDataSuccessfully() {
        DispatchQueue.main.async {
            self.contributorsTableView.reloadData()
        }
    }
    
    func didFailFetchingDataWithError(_ error: String!) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: error) { (action) in }
        }
    }
    
    func showIndicator() {
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: "Loading")
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
