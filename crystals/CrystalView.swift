//
//  CrystalView.swift
//  crystals
//
//  Created by Joshua Trommel on 2022-06-22.
//

import SwiftUI

struct Crystal: Hashable, Codable, Identifiable {
    var id = UUID()
    let composition, formation, colour: String
    let metaphysical: [String]
    
    enum CodingKeys: String, CodingKey{
        case composition, formation, colour, metaphysical
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        composition = try container.decode(String.self, forKey: .composition)
        formation = try container.decode(String.self, forKey: .formation)
        colour = try container.decode(String.self, forKey: .colour)
        metaphysical = try container.decode([String].self, forKey: .metaphysical)
    }
}

struct CrystalView: View {
    var body: some View {
        Text("Test")
    }
}

struct CrystalView_Previews: PreviewProvider {    
    static var previews: some View {
        CrystalView()
    }
}
