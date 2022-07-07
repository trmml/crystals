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
        let url = "https://crystal-identifier.herokuapp.com/img/"
        NavigationView {
            List {
                ForEach(Array(crystals.keys).sorted(), id:\.self) { key in
                    NavigationLink(destination: CrystalView(crystal: crystals[key], key: key)) {
                        AsyncImage(url: URL(string: "\(url)\(crystals[key]!.image)")) { img in
                            img
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .edgesIgnoringSafeArea(.all)
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 200, height: 200)
                        Text(key)
                    }.navigationTitle("Crystals")
                }
            }.onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        let url = URL(string: "https://crystal-identifier.herokuapp.com/api/crystals")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode([String:Crystal].self, from: data)
                DispatchQueue.main.async {
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
