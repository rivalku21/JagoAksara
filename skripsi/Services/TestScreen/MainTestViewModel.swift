//
//  MainTestViewModel.swift
//  skripsi
//
//  Created by Rival Fauzi on 18/01/24.
//

import Foundation
import Combine

class MainTestViewModel: ObservableObject {
    @Published var timeRemaining = 5 // Waktu yang tersisa, diinisialisasi dengan 5 detik
    @Published var maxTime = 5
    @Published var timeUp = false

    var levelOneQuestion: [TestLevelOneModel] = []
    private var timer: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
//    @Published var specificQuestion: [TestLevelOneModel] = []
    
    init() {
        let jsonData = readLocalJSONFile(forName: "level1")
        
        if let data = jsonData {
            if let record = testLevelOneParse(jsonData: data) {
                levelOneQuestion.append(contentsOf: record)
            }
        }
        
        $timeRemaining
            .sink { [weak self] newValue in
                guard let self = self else { return }
                if newValue == 0 {
                    self.timer?.cancel() // Menghentikan timer
                    self.timer = nil
                    // Jalankan fungsi lain saat countdown mencapai 0
//                    self.runAdditionalFunction()
                    timeUp = true
                }
            }
            .store(in: &cancellables)
    }
    
    func generateQuestion(aksara: [String]) -> [TestLevelOneModel] {
        var questions: [TestLevelOneModel] = []
        
        for char in aksara {
            questions.append(contentsOf: levelOneQuestion.filter({ $0.characterString == String(char) }))
        }
        
        var result: [TestLevelOneModel] = []
        
        let shuffledArray = questions.shuffled()
        
        for i in 0..<7 {
            result.append(shuffledArray[i])
        }
        
//        specificQuestion = result
        return result
    }
        
    // Fungsi untuk memulai kembali countdown, dipanggil oleh View
    func startCountdown(time: Int) {
        timeRemaining = time // Mengatur ulang waktu yang tersisa
        maxTime = time
        // Memulai timer countdown
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
            }
    }
    
    // Fungsi untuk menghentikan countdown
    func stopCountdown() {
        timer?.cancel() // Menghentikan timer
        timer = nil
    }
    
    // Fungsi untuk menambah waktu sebanyak 3 detik
    func addTime() {
        if (timeRemaining + 3) > 10 {
            timeRemaining = 10
        } else {
            timeRemaining += 3
        }
    }
}
