//
//  ViewController.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 2.05.2024.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let button = UIButton(primaryAction: nil)
    private var criptoViewModel = CriptoViewModel()
    lazy var selectedCoin: Coin? = nil
    let dataSource = [
        "Price By Incresing",
        "Price By Decresing",
        "Market Cap By Decresing",
        "Market Cap By Increasing",
        "Volume By Incresing",
        "Volume By Decresing",
        "Change By Incresing",
        "Change By Decresing",
        "Listed At By Incresing",
        "Listed At By Decresing"
    ]
    var actionClosure: ((UIAction) -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureActionClosure()
        configureFilterButton()
        addLabelToNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        showLoadingView()
        getCriptoCurrency()
    }

    private func addLabelToNavigationBar() {
        let label = UILabel()
        label.text = "Ranking List"
        label.textColor = colorFromHex(hex: "0E1959")
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }

    private func configureActionClosure() {
        actionClosure = { [weak self] action in
            guard let self = self else { return }
            if action.title == "Price By Incresing" { self.criptoViewModel.filterByPriceIncreasing() }
            if action.title == "Price By Decresing" { self.criptoViewModel.filterByPriceDecresing() }
            if action.title == "Market Cap By Decresing" { self.criptoViewModel.filterByMarketCapDecresing() }
            if action.title == "Market Cap By Increasing" { self.criptoViewModel.filterByMarketCapIncreasing() }
            if action.title == "Volume By Incresing" { self.criptoViewModel.filterByVolumeIncreasing() }
            if action.title == "Volume By Decresing" { self.criptoViewModel.filterByVolumeDecresing() }
            if action.title == "Change By Incresing" { self.criptoViewModel.filterByChangeIncreasing() }
            if action.title == "Change By Decresing" { self.criptoViewModel.filterByChangeDecresing() }
            if action.title == "Listed At By Incresing" { self.criptoViewModel.filterByListedAtIncreasing() }
            if action.title == "Listed At By Decresing" { self.criptoViewModel.filterByListedAtDecresing() }
            self.tableView.reloadData()
        }
    }

    private func configureFilterButton() {
        button.setTitle("Price", for: .normal)
        button.setImage(UIImage(named: "downArrow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 12)
        button.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        button.setTitleColor(colorFromHex(hex: "#6A61F2"), for: .normal)
        button.backgroundColor = colorFromHex(hex: "#E8E7FF")
        button.layer.cornerRadius = 16

        var menuChildren: [UIMenuElement] = []
        for fruit in dataSource {
            menuChildren.append(UIAction(title: fruit, handler: actionClosure))
        }

        button.menu = UIMenu(options: .displayInline, children: menuChildren)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true

        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }

    private func setTitleLabel(_ title: String) {
        self.button.setTitle(title, for: .normal)
        self.button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "CriptoCell", bundle: nil), forCellReuseIdentifier: "CriptoCell")
    }

    private func getCriptoCurrency() {
        criptoViewModel.getCriptoCurrency { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let criptoCurrency):
                self.criptoViewModel.criptoList = criptoCurrency.data.coins
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.hideLoadingView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func showLoadingView() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemBlue
        activityIndicator.startAnimating()
        tableView.backgroundView = activityIndicator
    }

    private func hideLoadingView() {
        tableView.backgroundView = nil
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! DetailVC
            detailVC.selectedCoin = selectedCoin
        }
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criptoViewModel.criptoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CriptoCell", for: indexPath) as! CriptoCell
        cell.configureCell(with: criptoViewModel.criptoList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCoin = criptoViewModel.criptoList[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: criptoViewModel.criptoList[indexPath.row])
    }
}

extension MainVC: StringToHexCode { }
