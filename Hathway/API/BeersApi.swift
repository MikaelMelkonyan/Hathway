//
//  BeersApi.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

final class BeersApi: Api {
    func beers(page: Int, completion: @escaping (Result<[Beer], Api.Error>) -> Void) {
        let parameters = ["page": page]
        request(path: "beers", method: .get, parameters: parameters, completion: completion)
    }
    
    func random(completion: @escaping (Result<[Beer], Api.Error>) -> Void) {
        request(path: "beers/random", method: .get, completion: completion)
    }
}
