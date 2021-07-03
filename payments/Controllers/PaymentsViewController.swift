//
//  PaymentsViewController.swift
//  payments
//
//  Created by Ekaterina on 2.07.21.
//

import UIKit

class PaymentsViewController: UIViewController {
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
    var token = ""
    var payments: [Payments] = []
    
    var tableView = UITableView()
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }

    override func viewDidLoad() {
        super.viewDidLoad()        
        addTableView()

        networkManager.getPayments(token: token) { [weak self] payments in
            guard let self = self else { return }
            self.payments = payments
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - UI
    
    private func addTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 0.0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PaymentsTableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.view.addSubview(tableView)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? PaymentsTableViewCell else {
            return dequeuedCell
        }
        let payment = payments[indexPath.row]
        cell.configureCell(for: payment)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat {
        return UITableView.automaticDimension
    }
}
