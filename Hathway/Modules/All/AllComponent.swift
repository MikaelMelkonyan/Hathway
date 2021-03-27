//
//  AllComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import SwiftUI

struct AllComponent: Component {
    let properties: Properties
    
    var body: some View {
        Text("ALL")
    }
}

extension AllComponent {
    struct Properties {}
}

// MARK: - Previews
struct AllComponent_Previews: PreviewProvider {
    static var previews: some View {
        AllComponent(properties: .init())
    }
}
