//
//  LoadingComponent.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import SwiftUI

struct LoadingComponent: Component {
    let properties: Properties
    
    var body: some View {
        ProgressView()
    }
}

extension LoadingComponent {
    struct Properties {}
}

// MARK: - Previews
struct LoadingComponent_Previews: PreviewProvider {
    static var previews: some View {
        LoadingComponent(properties: .init())
    }
}
