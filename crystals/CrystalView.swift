//
//  CrystalView.swift
//  crystals
//
//  Created by Joshua Trommel on 2022-06-22.
//

import SwiftUI

struct Crystal: Codable, Identifiable {
    var id = UUID()
    let composition, formation, colour, image: String
    let metaphysical: [String]
    
    enum CodingKeys: String, CodingKey{
        case composition, formation, colour, image, metaphysical
    }
}

struct CrystalView: View {
    @State var crystal: Crystal?
    @State var key = ""
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: crystal!.image)) { img in
                img
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
                    .edgesIgnoringSafeArea(.all)
            } placeholder: {
                ProgressView()
            }.frame(width: 200, height: 200)
        }
        List {
            Text(key).font(.largeTitle)
            Text(crystal!.composition)
            Text(crystal!.formation)
            Text(crystal!.colour)
            
            ForEach(crystal!.metaphysical, id:\.self) { meta in
                Text(meta)
            }
        }
    }
}

struct CrystalView_Previews: PreviewProvider {    
    static var previews: some View {
        CrystalView()
    }
}
