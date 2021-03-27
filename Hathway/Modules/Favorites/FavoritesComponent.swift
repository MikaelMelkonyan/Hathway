//
//  FavoritesComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import SwiftUI

struct FavoritesComponent: Component {
    let properties: Properties
    
    var body: some View {
        Text("FAVORITES")
    }
}

extension FavoritesComponent {
    struct Properties {}
}

// MARK: - Previews
struct FavoritesComponent_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesComponent(properties: .init())
    }
}
