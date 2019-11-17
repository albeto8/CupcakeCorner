//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Mario Alberto Barragán Espinosa on 15/11/19.
//  Copyright © 2019 Mario Alberto Barragán Espinosa. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Orders()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.currentOrder.type) {
                        ForEach(0..<OrderStruct.types.count, id: \.self) {
                            Text(OrderStruct.types[$0])
                        }
                    }

                    Stepper(value: $order.currentOrder.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.currentOrder.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.currentOrder.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if order.currentOrder.specialRequestEnabled {
                        Toggle(isOn: $order.currentOrder.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.currentOrder.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
