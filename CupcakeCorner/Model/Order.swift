//
//  Order.swift
//  CupcakeCorner
//
//  Created by Mario Alberto Barragán Espinosa on 15/11/19.
//  Copyright © 2019 Mario Alberto Barragán Espinosa. All rights reserved.
//

import Foundation

class Orders: ObservableObject {
    @Published var currentOrder = OrderStruct()
}

struct OrderStruct: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmptyOrWhitespace() || streetAddress.isEmptyOrWhitespace() || city.isEmptyOrWhitespace() || zip.isEmptyOrWhitespace() {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}

extension String {
    func isEmptyOrWhitespace() -> Bool {

        // Check empty string
        if self.isEmpty {
            return true
        }
        // Trim and check empty string
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
}
