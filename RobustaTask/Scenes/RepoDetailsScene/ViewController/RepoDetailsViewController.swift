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

    deinit {
        print("Repo details deinit")
    }
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
        //loop on languages dictionary to calculate precntage and append it to charts
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
    func updateUI(withOwnerName name: String!, repoName: String!, avatarURL url: URL!, repoDescription description: String!, languages: [AnyHashable : Any]!, totalLines: Int32) {
            self.ownerImageView.kf.indicatorType = .activity
            self.ownerImageView.kf.setImage(with: url)
            self.ownerNameLabel.text = name
            self.repoNameLabel.text = repoName
            if let languages = languages as? [String : Int] {
                self.updateChartsData(from: languages , totalLines: Int(totalLines))
            }
            if let description = description {
                self.repoDescriptionLabel.text = description
            }
            else{
                self.repoDescriptionLabel.isHidden = true
            }
            UIView.animate(withDuration: 0.3) {
                self.containerView.alpha = 1
            }
        }

    func showIndicator() {
        SVProgressHUD.show(withStatus: "Loading")
    }
    
    func hideIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func didFailFetchingDataWithError(_ error: String!) {
        self.showAlert(title: "Error", message: error) { _ in}
    }
    
}
