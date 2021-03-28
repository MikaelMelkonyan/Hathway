//
//  Beer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

struct Beer: Identifiable {
    let id: Int
    let name: String
    let tagline: String
    let description: String
    let firstBrewed: String
    let imageURL: String?
}

// MARK: - Decodable
extension Beer: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        tagline = try container.decode(String.self, forKey: .tagline)
        description = try container.decode(String.self, forKey: .description)
        firstBrewed = try container.decode(String.self, forKey: .firstBrewed)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description
        case firstBrewed = "first_brewed"
        case imageURL = "image_url"
    }
}
