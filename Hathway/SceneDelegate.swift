//
//  SceneDelegate.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let store = AppEnvironmentStore(store: AppStore(initial: AppState()))
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        store.subscribe(AllMiddleware.self)
        store.subscribe(RandomMiddleware.self)
        
        let contentView = TabsContainer().environmentObject(store)
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
        
        store.dispatch(Actions.AppLaunched())
    }
}
