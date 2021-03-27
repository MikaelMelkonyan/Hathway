//
//  RandomComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import SwiftUI

struct RandomComponent: Component {
    let properties: Properties
    
    var body: some View {
        Text("RANDOM")
    }
}

extension RandomComponent {
    struct Properties {}
}

// MARK: - Previews
struct RandomComponent_Previews: PreviewProvider {
    static var previews: some View {
        RandomComponent(properties: .init())
    }
}
