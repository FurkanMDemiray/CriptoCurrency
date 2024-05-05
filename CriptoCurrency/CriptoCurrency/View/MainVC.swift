//
//  ViewController.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 2.05.2024.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let button = UIButton(type: .custom)

    private var criptoViewModel = CriptoViewModel()
    lazy var selectedCoin: Coin? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        addFilterButton()
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

    private func addFilterButton() {
        button.setTitle("Price", for: .normal)
        button.setImage(UIImage(named: "downArrow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        button.setTitleColor(colorFromHex(hex: "#6A61F2"), for: .normal)
        button.backgroundColor = colorFromHex(hex: "#E8E7FF")
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)

        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }

    private func setTitleLabel(_ title: String) {
        self.button.setTitle(title, for: .normal)
        self.button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
    }

    @objc private func filterButtonTapped() {
        let alert = UIAlertController(title: "Filter", message: "Filter by", preferredStyle: .alert)
        let priceAction = UIAlertAction(title: "Price", style: .default) { _ in
            self.criptoViewModel.filterByPrice()
            self.setTitleLabel("Price")
            self.tableView.reloadData()
        }
        let marketCapAction = UIAlertAction(title: "Market Cap", style: .default) { _ in
            self.criptoViewModel.filterByMarketCap()
            self.setTitleLabel("Market Cap")
            self.tableView.reloadData()
        }
        let volumeAction = UIAlertAction(title: "24h Volume", style: .default) { _ in
            self.criptoViewModel.filterByVolume()
            self.setTitleLabel("24h Volume")
            self.tableView.reloadData()
        }
        let changeAction = UIAlertAction(title: "Change", style: .default) { _ in
            self.criptoViewModel.filterByChange()
            self.setTitleLabel("Change")
            self.tableView.reloadData()
        }
        let listedAtAction = UIAlertAction(title: "Listed At", style: .default) { _ in
            self.criptoViewModel.filterByListedAt()
            self.setTitleLabel("Listed At")
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(priceAction)
        alert.addAction(marketCapAction)
        alert.addAction(volumeAction)
        alert.addAction(changeAction)
        alert.addAction(listedAtAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
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
