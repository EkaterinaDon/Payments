//
//  PaymentsTableViewCell.swift
//  payments
//
//  Created by Ekaterina on 3.07.21.
//

import UIKit

class PaymentsTableViewCell: UITableViewCell {

    // MARK: - Subviews

    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var createdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.descriptionLabel, self.amountLabel, self.descriptionLabel].forEach { $0.text = nil }
    }
    
    // MARK: - Cell Configuration
    
    func configureCell(for model: Payments) {
        self.descriptionLabel.text = model.desc
        if let amount = model.amount, let currency = model.currency {
            self.amountLabel.text = "\(amount)" + " \(currency)"
        }
        if let date = model.created {
            self.createdLabel.text = "\(convertDate(dateValue: date))"
        }
    }
    
    // MARK: - Constraints
    
    private func configureUI() {
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.amountLabel)
        self.contentView.addSubview(self.createdLabel)
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2.0),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5.0),
            self.descriptionLabel.widthAnchor.constraint(equalToConstant: 200.0),
            
            self.amountLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0),
            self.amountLabel.widthAnchor.constraint(equalToConstant: 200.0),
            self.amountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5.0),
            self.amountLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.createdLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 2.0),
            self.createdLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5.0),
            self.createdLabel.widthAnchor.constraint(equalToConstant: 200.0),
            self.createdLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2.0)
            ])
    }
    
}

extension PaymentsTableViewCell {
    func convertDate(dateValue: Double) -> String {
        let truncatedTime = Double(dateValue / 1000)
        let date = Date(timeIntervalSince1970: TimeInterval(truncatedTime))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
}
