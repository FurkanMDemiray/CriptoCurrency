//
//  ViewController.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 2.05.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var criptoViewModel = CriptoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        addFilterButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        showLoadingView()
        getCriptoCurrency()
    }

    private func addFilterButton() {
       // price, marketCap, 24h Volume, change, listedAt filter dropdown button
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton

    }

    @objc private func filterButtonTapped() {
        let alert = UIAlertController(title: "Filter", message: "Filter by", preferredStyle: .alert)
        let priceAction = UIAlertAction(title: "Price", style: .default) { _ in
            //self.criptoViewModel.filterByPrice()
            self.tableView.reloadData()
        }
        let marketCapAction = UIAlertAction(title: "Market Cap", style: .default) { _ in
            //self.criptoViewModel.filterByMarketCap()
            self.tableView.reloadData()
        }
        let volumeAction = UIAlertAction(title: "24h Volume", style: .default) { _ in
            //self.criptoViewModel.filterByVolume()
            self.tableView.reloadData()
        }
        let changeAction = UIAlertAction(title: "Change", style: .default) { _ in
            //self.criptoViewModel.filterByChange()
            self.tableView.reloadData()
        }
        let listedAtAction = UIAlertAction(title: "Listed At", style: .default) { _ in
            //self.criptoViewModel.filterByListedAt()
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
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criptoViewModel.criptoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CriptoCell", for: indexPath) as! CriptoCell
        cell.configureCell(with: criptoViewModel.criptoList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailVC", sender: criptoViewModel.criptoList[indexPath.row])
    }
}
