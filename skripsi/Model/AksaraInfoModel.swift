//
//  AksaraInfoModel.swift
//  skripsi
//
//  Created by Rival Fauzi on 03/01/24.
//

import Foundation

struct AksaraInfoModel: Decodable, Hashable {
    let characterString: String
    let name: String
    let description: String
    let example: String?
    
    private enum CodingKeys: String, CodingKey {
        case characterString = "character"
        case name
        case description
        case example
    }
    
    init(characterString: String, name: String, description: String, example: String? = nil) {
        self.characterString = characterString
        self.name = name
        self.description = description
        self.example = example
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        characterString = try container.decode(String.self, forKey: .characterString)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        if container.contains(.example) {
            example = try container.decode(String.self, forKey: .example)
        } else {
            example = nil
        }
    }
}

struct InfoModel: Decodable, Hashable {
    let section: Int
    let title: String
    let description: String
    let description2: String
    let note: String
    let note2: String
    let text: [AksaraInfoModel]
    
    enum CodingKeys: CodingKey {
        case section
        case title
        case description
        case description2
        case note
        case note2
        case text
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.section = try container.decode(Int.self, forKey: .section)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.description2 = try container.decode(String.self, forKey: .description2)
        self.note = try container.decode(String.self, forKey: .note)
        self.note2 = try container.decode(String.self, forKey: .note2)
        self.text = try container.decode([AksaraInfoModel].self, forKey: .text)
    }
}
