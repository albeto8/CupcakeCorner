//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Mario Alberto Barragán Espinosa on 15/11/19.
//  Copyright © 2019 Mario Alberto Barragán Espinosa. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Orders

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.currentOrder.name)
                TextField("Street Address", text: $order.currentOrder.streetAddress)
                TextField("City", text: $order.currentOrder.city)
                TextField("Zip", text: $order.currentOrder.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.currentOrder.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Orders())
    }
}
