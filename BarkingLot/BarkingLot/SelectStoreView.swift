//
//  SelectStoreView.swift
//  BarkingLot
//
//  Created by Michael Brünen on 26.04.21.
//

import SwiftUI

struct SelectStoreView: View {
    @EnvironmentObject var model: DataModel

    @State private var selection: Store?
    @State private var searchText = ""
    @State private var matchingStores = [Store]()

    let allStores = Bundle.main.decode([Store].self, from: "stores.json")

    var body: some View {
        VStack {
            TextField("Search for a store...", text: $searchText)
                .disableAutocorrection(true)
                .padding()

            List(matchingStores, selection: $selection) { store in
                NavigationLink(destination: SelectServiceView(store: store), tag: store, selection: $selection) {
                    VStack(alignment: .leading) {
                        Text(store.name)
                            .font(.headline)
                        Text(store.address)
                            .foregroundColor(.secondary)
                    }
                }
                .tag(store)
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Select Store")
        .onAppear { runSearch(for: searchText) }
        .onChange(of: searchText, perform: runSearch)
        .onReceive(model.$selectedStore) { newValue in
            selection = allStores.first(where: { $0.id == newValue })
        }
    }

    func runSearch(for value: String) {
        if searchText.isEmpty {
            matchingStores = allStores
        } else {
            matchingStores = allStores.filter {
                $0.name.localizedCaseInsensitiveContains(value) || $0.address.localizedCaseInsensitiveContains(value)
            }
        }
    }
}

struct SelectStoreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectStoreView()
    }
}
