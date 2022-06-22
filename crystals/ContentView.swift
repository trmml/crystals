//
//  ContentView.swift
//  crystals
//
//  Created by Joshua Trommel on 2022-06-20.
//

import SwiftUI

struct ContentView: View {
    @State private var crystals = [String:Crystal]()
    
    var body: some View {
        Text("Crystals").font(.largeTitle)
        NavigationView {
            List {
                ForEach(Array(crystals.keys), id:\.self) { key in
                    HStack {
                        NavigationLink(destination: CrystalView()) {
                            Text(key)
                        }
                    }
                }
            }.onAppear(perform:loadData)
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://lit-castle-74820.herokuapp.com/api/crystals") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode([String:Crystal].self, from: data)
                DispatchQueue.main.async {
                    print(decoded)
                    self.crystals = decoded
               }
            } catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
