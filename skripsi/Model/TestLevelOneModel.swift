//
//  TestLevelOneModel.swift
//  skripsi
//
//  Created by Rival Fauzi on 18/01/24.
//

import Foundation

struct TestLevelOneModel: Decodable, Hashable {
    let level: Int
    let characterString: String
    let name: String
    let answer: [String]
    let latin: String
    
    private enum CodingKeys: String, CodingKey {
        case level
        case characterString = "character"
        case name
        case answer
        case latin
    }
    
    var character: Character {
        guard let firstCharacter = characterString.first else {
            return "?"
        }
        return firstCharacter
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        level = try container.decode(Int.self, forKey: .level)
        characterString = try container.decode(String.self, forKey: .characterString)
        name = try container.decode(String.self, forKey: .name)
        answer = try container.decode([String].self, forKey: .answer)
        if container.contains(.latin) {
            latin = try container.decode(String.self, forKey: .latin)
        } else {
            latin = ""
        }
    }
}
