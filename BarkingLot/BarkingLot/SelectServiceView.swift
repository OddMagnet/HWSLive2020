//
//  SelectServiceView.swift
//  BarkingLot
//
//  Created by Michael Brünen on 26.04.21.
//

import SwiftUI

struct SelectServiceView: View {
    let services = Bundle.main.decode([Service].self, from: "services.json")
    let store: Store
    
    var body: some View {
        List(services) { service in
            NavigationLink(destination: PurchaseView(store: store, service: service)) {
                VStack(alignment: .leading) {
                    Text(service.name)
                        .font(.title)
                    Text(service.description)

                    HStack {
                        Text("Ready by: ") +
                            Text(Date().addingTimeInterval(service.duration), style: .time)
                            .bold()

                        Spacer()

                        Text(service.formattedPrice)
                            .padding(18)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .padding(5)
                    }
                }
                .padding()
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(store.name)
    }
}

struct SelectServiceView_Previews: PreviewProvider {
    static var previews: some View {
        SelectServiceView(store: Store.example)
    }
}
