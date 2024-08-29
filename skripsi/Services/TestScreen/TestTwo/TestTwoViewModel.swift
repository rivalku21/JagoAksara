//
//  TestTwoViewModel.swift
//  skripsi
//
//  Created by Rival Fauzi on 07/02/24.
//

import Foundation
import CoreML
import Vision
import SwiftUI

class TestTwoViewModel: ObservableObject {
    func classifyImage(drawnImage: UIImage?) -> String? {
        var coreMLModel: MyObjectDetector3?
        var resultData: [String : Double] = [:]
        
        do {
            coreMLModel = try MyObjectDetector3(configuration: MLModelConfiguration())
        } catch {
            print(error)
        }
        
        guard let drawnImage = drawnImage?.resize(to: CGSize(width: 416, height: 416)), let pixelBuffer = drawnImage.toCVPixelBuffer() else {
            return nil
        }
        
        let modelInput = MyObjectDetector3Input(imagePath: pixelBuffer, iouThreshold: nil, confidenceThreshold: nil)

        do {
            let prediction = try coreMLModel?.prediction(input: modelInput)
            
            if let classScores = prediction?.confidence as? MLMultiArray {
                // Access user-defined metadata for classes
                if let classes = coreMLModel?.model.modelDescription.classLabels as? [String] {
                    var myDictionary = [String: Double]()
                    
                    // Assuming classScores.shape[1] is the number of classes
                    let numberOfClasses = classScores.shape[1].intValue
                    
                    // Iterate through the class indices
                    if classScores.count == 22 {
                        for classIndex in 0..<(numberOfClasses - 1) {
                            // Access the confidence value for the class
                            let confidence = classScores[[0, NSNumber(value: classIndex)]] as! Double
                            
                            // Access the class label from the classes array
                            let classLabel = classes[classIndex]
                            
                            if confidence > 0.01 {
                                myDictionary[classLabel] = confidence * 100
                            }
                        }
                        
                        let sortedDictionary = myDictionary.sorted { $0.value > $1.value }
                        
                        let topEntriesCount = min(5, sortedDictionary.count)
                        let topEntries = sortedDictionary.prefix(topEntriesCount)

                        let sortedDictionaryResult = Dictionary(uniqueKeysWithValues: topEntries.map { ($0.key, $0.value) })

                        resultData = sortedDictionaryResult
                    }
                } else {
                    print("User-defined metadata 'classes' not found.")
                }
            } else {
                print("Output is not an MLMultiArray or does not contain class scores.")
            }
        } catch {
            print("Failed to perform image classification: \(error)")
        }
        
        let combinedKeys = resultData.keys.joined(separator: "")

        print(combinedKeys)
        return combinedKeys
    }
}
