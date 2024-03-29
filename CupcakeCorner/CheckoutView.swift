//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Mario Alberto Barragán Espinosa on 15/11/19.
//  Copyright © 2019 Mario Alberto Barragán Espinosa. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Orders
    
    @State private var alertTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(decorative: "cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(hidden: true)

                    Text("Your total is $\(self.order.currentOrder.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text((self.alertTitle)), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.currentOrder) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                self.alertTitle = "No data in response"
                self.confirmationMessage = "\(error?.localizedDescription ?? "Unknown error")."
                self.showingConfirmation = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(OrderStruct.self, from: data) {
                self.alertTitle = "Thank you!"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderStruct.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Orders())
    }
}
