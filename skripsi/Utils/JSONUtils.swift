//
//  JSONUtils.swift
//  skripsi
//
//  Created by Rival Fauzi on 03/01/24.
//

import Foundation

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
    
//    if let path = Bundle.main.path(forResource: name, ofType: "json") {
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path))
//            let characters = try JSONDecoder().decode([AksaraInfoModel].self, from: data)
//
//            print(characters)
//        } catch {
//            print("Error decoding JSON: \(error)")
//        }
//    } else {
//        print("JSON file not found.")
//    }

}

func aksaraInfoParse(jsonData: Data) -> [AksaraInfoModel]? {
    do {
        let decodedData = try JSONDecoder().decode([AksaraInfoModel].self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}

func testLevelOneParse(jsonData: Data) -> [TestLevelOneModel]? {
    do {
        let decodedData = try JSONDecoder().decode([TestLevelOneModel].self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}

func infoDataParse(jsonData: Data) -> [InfoModel]? {
    do {
        let decodedData = try JSONDecoder().decode([InfoModel].self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}
