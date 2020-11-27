//
//  RepoDetailsViewController.swift
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

import UIKit
import Charts
import SVProgressHUD
import Kingfisher

class RepoDetailsViewController: UIViewController {

    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var pieChartView: PieChartView!
    @objc var presenter: RepoDetailsPresenterImpl?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        initPieChart()
        containerView.alpha = 0
        presenter?.viewDidLoad()
    }

    @IBAction func githubButtonClicked(_ sender: Any) {
        presenter?.didClickOnGithubButton()
    }
    
    @IBAction func contributorsButtonClicked(_ sender: Any) {
        presenter?.didClickOnContributorsButton()
    }
    
    func initPieChart()
    {
        let chartCenterText = NSMutableAttributedString(string: "Languages")
        chartCenterText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 15)!], range: NSRange(location: 0, length: chartCenterText.length))
        pieChartView.centerAttributedText = chartCenterText
        
    }
    func updateChartsData(from languagesDictionary: [String:Int] , totalLines: Int)
    {
        var chartsData = [PieChartDataEntry]()
        for (key , value) in languagesDictionary {
            let pieChartDataEntry = PieChartDataEntry(value: ((Double(value) / Double(totalLines)) * 100), label: key)
            chartsData.append(pieChartDataEntry)
        }
        let chartsDataSet = PieChartDataSet(entries: chartsData, label: nil)
        let chartData = PieChartData(dataSet: chartsDataSet)
        let colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            
        chartsDataSet.colors = colors
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        chartData.setValueFont(.systemFont(ofSize: 11, weight: .light))
        chartData.setValueTextColor(.black)
        pieChartView.data = chartData
    }
}

extension RepoDetailsViewController: RepoDetailsView {

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
    
    func updateUI(with model: RepoModel!, languages: [AnyHashable : Any]!, totalLines: Int32) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.ownerImageView.kf.indicatorType = .activity
            self.ownerImageView.kf.setImage(with: model.ownerAvatarURL)
            self.ownerNameLabel.text = model.ownerName
            self.repoNameLabel.text = model.repoName
            self.updateChartsData(from: languages as! [String: Int], totalLines: Int(totalLines))
            if let description = model.repoDescription {
                self.repoDescriptionLabel.text = description
            }
            else{
                self.repoDescriptionLabel.isHidden = true
            }
            UIView.animate(withDuration: 0.3) {
                self.containerView.alpha = 1
            }
        }
    }
    
    func didFailFetchingDataWithError(_ error: String!) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: error) { _ in}
        }
    }
    
}
