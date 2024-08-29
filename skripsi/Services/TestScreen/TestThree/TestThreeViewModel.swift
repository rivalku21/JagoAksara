//
//  TestThreeViewModel.swift
//  skripsi
//
//  Created by Rival Fauzi on 25/01/24.
//

import Foundation

class TestThreeViewModel {
    func generateRandomAnswer(listAnswer: [String], answer: String) -> [String] {
        var dataArray = listAnswer
        var randomAnswer: [String] = []
        
        for char in answer {
            randomAnswer.append(String(char))
            
            if let indexToRemove = dataArray.firstIndex(where: { $0 == String(char) }) {
                dataArray.remove(at: indexToRemove)
            }
        }
        
        
        if randomAnswer.count < 7 {
            let shuffledArray = dataArray.shuffled()
            let initialCount = randomAnswer.count
            
            for index in initialCount..<7 {
                randomAnswer.append(shuffledArray[index - initialCount])
            }
        }
        
        return randomAnswer.shuffled()
    }
}
