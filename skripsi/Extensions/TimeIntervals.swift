//
//  TimeIntervals.swift
//  skripsi
//
//  Created by Rival Fauzi on 30/01/24.
//

import Foundation

extension TimeInterval {
    func formattedMilliseconds() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        let milliseconds = Int(self * 100) % 100
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
    
    func formattedSeconds() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
