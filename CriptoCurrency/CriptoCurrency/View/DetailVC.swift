//
//  DetailVC.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 4.05.2024.
//

import UIKit
import Charts

class DetailVC: UIViewController {

    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currencyVİew: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var changeOfCurrencyLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var lineChartButton: UIButton!
    @IBOutlet weak var barChartButton: UIButton!

    var lineChartView: LineChart?
    var barChartView: BarChartView?
    lazy var selectedCoin: Coin? = nil

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureView()
        setLabels()
    }

    private func configureView() {
        currencyVİew.layer.cornerRadius = 10
        currencyVİew.layer.borderWidth = 1
        currencyVİew.layer.borderColor = UIColor.lightGray.cgColor
        currencyVİew.layer.shadowColor = UIColor.black.cgColor
        currencyVİew.layer.shadowOffset = CGSize(width: 0, height: 1)
        currencyVİew.layer.shadowOpacity = 0.2
        currencyVİew.layer.shadowRadius = 1
    }

    private func configureHighAndLowText() {
        let highValue = selectedCoin?.sparkline?.max()
        let lowValue = selectedCoin?.sparkline?.min()

        let normalColor = colorFromHex(hex: "#0E1959")
        let highValueColor = colorFromHex(hex: "#3ED2A3")
        let lowValueColor = colorFromHex(hex: "#F96A6A")

        let highText = "High: "
        let lowText = "Low: "

        let highAttributedString = NSMutableAttributedString(string: "\(highText)\(formatter.string(from: NSDecimalNumber(string: highValue)) ?? "")")
        highAttributedString.addAttribute(.foregroundColor, value: normalColor, range: NSRange(location: 0, length: highText.count))
        highAttributedString.addAttribute(.foregroundColor, value: highValueColor, range: NSRange(location: highText.count, length: highAttributedString.length - highText.count))

        let lowAttributedString = NSMutableAttributedString(string: "\(lowText)\(formatter.string(from: NSDecimalNumber(string: lowValue)) ?? "")")
        lowAttributedString.addAttribute(.foregroundColor, value: normalColor, range: NSRange(location: 0, length: lowText.count))
        lowAttributedString.addAttribute(.foregroundColor, value: lowValueColor, range: NSRange(location: lowText.count, length: lowAttributedString.length - lowText.count))

        highLabel.attributedText = highAttributedString
        lowLabel.attributedText = lowAttributedString
    }

    private func setLabels() {
        configureHighAndLowText()
        if let shotName = selectedCoin?.symbol {
            shortNameLabel.text = shotName
        }
        if let name = selectedCoin?.name {
            nameLabel.text = name
        }
        if let price = selectedCoin?.price {
            priceLabel.text = formatter.string(from: NSDecimalNumber(string: price))
        }
        if let price = selectedCoin?.price {
            let priceDouble = Double(price)
            priceLabel.text = formatter.string(from: NSDecimalNumber(value: priceDouble ?? 0.0))
            if let change = selectedCoin?.change {
                let (changeOfCurrencyInDollar, color) = calculateChangeOfCurrencyInDollar(change: change, price: priceDouble ?? 0.0)
                changeOfCurrencyLabel.text = changeOfCurrencyInDollar
                changeOfCurrencyLabel.textColor = colorFromHex(hex: color)
            }
        }
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }

    private func addLineChart() {
        barChartView?.removeFromSuperview()
        let screenHight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width

        lineChartView = LineChart(frame: CGRect(x: 0, y: screenHight / 3, width: screenWidth, height: currencyVİew.frame.height * 4))

        let sparkline = selectedCoin?.sparkline
        let dataEntries = lineChartView?.convertToPointEntry(sparkline ?? [])

        lineChartView?.backgroundColor = .white
        lineChartView?.dataEntries = dataEntries
        self.view.addSubview(lineChartView ?? LineChart())
    }

    private func addBarChart() {
        lineChartView?.removeFromSuperview()
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width

        if screenHeight < 750 {
            barChartView = BarChartView(frame: CGRect(x: 0, y: screenHeight / 2.7, width: screenWidth, height: currencyVİew.frame.height * 3.5))
        }
        else {
            barChartView = BarChartView(frame: CGRect(x: 0, y: screenHeight / 3, width: screenWidth, height: currencyVİew.frame.height * 4.2))
        }

        let sparkline = selectedCoin?.sparkline
        let dataEntries = barChartView?.convertToPointEntry(sparkline ?? [])

        barChartView?.backgroundColor = .white
        barChartView?.dataEntries = dataEntries
        self.view.addSubview(barChartView ?? BarChartView())
    }

    @IBAction func lineChartButtonClicked(_ sender: Any) {
        addLineChart()
    }
    @IBAction func barChartButtonClicked(_ sender: Any) {
        addBarChart()
    }
}

