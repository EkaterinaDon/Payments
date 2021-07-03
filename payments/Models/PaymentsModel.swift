//
//  PaymentsModel.swift
//  payments
//
//  Created by Ekaterina on 2.07.21.
//

import Foundation

class Payments {

        var amount : Double?
        var created : Double?
        var currency : String?
        var desc : String?
    
    internal init(amount: Double, created: Double, currency: String? = nil, desc: String) {
        self.amount = amount
        self.created = created
        self.currency = currency
        self.desc = desc
    }
}
