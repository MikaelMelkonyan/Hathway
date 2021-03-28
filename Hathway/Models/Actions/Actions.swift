//
//  Actions.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

enum Actions {
    struct AppLaunched: Actionable {}
    
    struct LoadPage: Actionable, Identifiable {
        let pageNumber: Int
        let id: String
        
        init(pageNumber: Int = 1, id: String) {
            self.pageNumber = pageNumber
            self.id = id
        }
    }
    
    struct DidLoadItems<Item>: Actionable, Identifiable {
        let items: [Item]
        let id: String
    }
    
    struct DidGetError: Actionable, Identifiable {
        let error: Api.Error
        let id: String
    }
    
    struct AddToFavorites: Actionable, Identifiable {
        let collectionID: String
        let id: Int
    }
    
    struct RemoveFromFavorites: Actionable, Identifiable {
        let collectionID: String
        let id: Int
    }
}
