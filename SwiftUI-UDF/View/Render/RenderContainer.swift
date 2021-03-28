//
//  RenderContainer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 08.03.2021.
//  Copyright © 2021 Hathway. All rights reserved.
//

import SwiftUI

struct RenderContainer<V: View>: Container {
    typealias ContainerComponent = RenderComponent<V>
    
    private let view: V
    
    init(view: V) {
        self.view = view
    }
    
    func properties(store: EnvironmentStore<Void>) -> ContainerComponent.Properties {
        .init(view: view)
    }
    
    var body: some View {
        view
    }
}
