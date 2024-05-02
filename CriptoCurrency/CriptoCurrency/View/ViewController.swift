//
//  ViewController.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 2.05.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var criptoViewModel = CriptoViewModel()
    var criptoList = [Coin]() {
        didSet {
            //criptoList = criptoList.sorted { $0.rank!  < $1.rank!  }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            for cripto in criptoList {
                print(cripto.iconURL)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getCriptoCurrency()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "CriptoCell", bundle: nil), forCellReuseIdentifier: "CriptoCell")
    }

    private func getCriptoCurrency() {
        criptoViewModel.getCriptoCurrency { result in
            switch result {
            case .success(let criptoCurrency):
                self.criptoList = criptoCurrency.data.coins
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criptoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CriptoCell", for: indexPath) as! CriptoCell
        cell.configureCell(with: criptoList[indexPath.row])
        return cell
    }
}
