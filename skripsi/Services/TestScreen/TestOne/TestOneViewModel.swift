//
//  TestOneViewModel.swift
//  skripsi
//
//  Created by Rival Fauzi on 18/01/24.
//

import Foundation

class TestOneViewModel {
    func generateRandomAnswer(listAnswer: [String], answer: String) -> [String] {
        var dataArray = listAnswer
        var randomAnswer: [String] = []
        
        randomAnswer.append(answer)
        
        if let indexToRemove = dataArray.firstIndex(where: { $0 == answer }) {
            dataArray.remove(at: indexToRemove)
        } else {
            print("Item not found in the array.")
        }
        
        let shuffledArray = dataArray.shuffled()
        randomAnswer.append(shuffledArray[0])
        randomAnswer.append(shuffledArray[1])
        
        return randomAnswer.shuffled()
    }
    
    func checkAnswer() {
        
    }
}
