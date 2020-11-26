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

        // Do any additional setup after loading the view.
    }

}

extension HomeViewController: HomeView {
    
}
