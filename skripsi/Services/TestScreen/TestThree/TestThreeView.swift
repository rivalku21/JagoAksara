//
//  TestThreeView.swift
//  skripsi
//
//  Created by Rival Fauzi on 03/01/24.
//

import SwiftUI

struct TestThreeView: View {
    @Binding var choosenAnswer: String
    @Binding var isCheck: Bool
    @Binding var isFailed: Bool
    var question: TestLevelOneModel
    let viewModel: TestThreeViewModel = TestThreeViewModel()
    
    let exception = "NCRKFTWLDJYVMGBQZeiuh=\\"
    @State var items: [String] = []
    @State private var disabledItems: [Int] = []
    
    let imageNames = ["Image1", "Image2", "Image3", "Image4", "Image5","Image6", "Image7"]
    @State private var selectedImage: String?
    
    var body: some View {
        GeometryReader { geometry in
            let columns = Int(geometry.size.width / 80)
            let rows = (items.count - 1) / columns + 1
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Susun aksara berikut!")
                    .font(.headline)
                
                HStack {
                    Spacer()
                    
                    VStack {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 342, height: 144)
                                
                                HStack {
                                    Image("quizCharacterWithBatik")
                                        .resizable()
                                        .frame(width: 129, height: 166)
                                        .offset(x: 10, y: -11)
                                        .padding()
                                        .padding(.trailing)
                                    
                                    Text("\"\(question.latin.capitalized)\"")
                                        .font(.title2)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                            }
                            .foregroundColor(.black)
                        }
                        
                        Text(" \(choosenAnswer) ")
                            .font(.custom("HanacarakaNormal", size: 40))
                            .offset(y: 15)
                        
                        Rectangle()
                            .frame(height: 1)
                            .padding(.bottom, 30)

                        
                        ForEach(0..<rows, id: \.self) { row in
                            HStack {
                                ForEach(0..<columns, id: \.self) { column in
                                    let index = row * columns + column
                                    if index < items.count {
                                        Button {
                                            if disabledItems.contains(index) {
                                                delChar(index: index)
                                            } else {
                                                addChar(char: items[index], index: index)
                                            }
                                        } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .foregroundColor(Color(.systemGray5))
                                                
                                                if exception.contains(items[index]) {
                                                    Image("\(items[index])")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 40)
                                                        .foregroundColor(.black)
                                                        .padding(.top)
                                                } else if items[index] == "[o" {
                                                    Image("\(items[index])")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 50)
                                                        .foregroundColor(.black)
                                                } else if items[index] == "/" {
                                                    Image("layar")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 50)
                                                        .foregroundColor(.black)
                                                } else {
                                                    Text(items[index])
                                                        .font(.custom("HanacarakaNormal", size: 24))
                                                        .foregroundColor(.black)
                                                }
                                            }
                                        }
                                        .frame(width: 70, height: 60)
                                        .opacity(disabledItems.contains(index) ? 0.4 : 1)
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.vertical)
                
                Spacer()
                
//                HStack {
//                    Button(action: {
//                        choosenAnswer = ""
//                        disabledItems.removeAll()
//                    }, label: {
//                        Text("Hapus")
//                            .foregroundColor(.black)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background {
//                                RoundedRectangle(cornerRadius: 12)
//                                    .foregroundColor(Color(.systemGray6))
//                                    .shadow(color: Color.black.opacity(0.15), radius: 2, x: 2, y: 2)
//                            }
//                    })
//                }

            }
        }
        .onAppear {
            items = viewModel.generateRandomAnswer(listAnswer: question.answer, answer: question.name)
            selectedImage = imageNames.randomElement()
        }
        .onChange(of: question) { newValue in
            items = viewModel.generateRandomAnswer(listAnswer: newValue.answer, answer: newValue.name)
            disabledItems.removeAll()
            selectedImage = imageNames.randomElement()
        }
        .onChange(of: choosenAnswer) { newValue in
            if newValue != "" {
                isCheck = false
            } else {
                isCheck = true
            }
        }
        .onChange(of: isFailed) { newValue in
            if !newValue {
                disabledItems.removeAll()
            }
        }
    }
    
    func addChar(char: String, index: Int) {
        choosenAnswer.append(char)
        disabledItems.append(index)
    }
    
    func delChar(index: Int) {
        let charIndex = disabledItems.firstIndex(where: { $0 == index }) ?? -1
        
        let indexToRemove = choosenAnswer.index(choosenAnswer.startIndex, offsetBy: charIndex)

        choosenAnswer.remove(at: indexToRemove)
        disabledItems.removeAll(where: { $0 == index })
    }
}

#Preview {
//    TestThreeView()
    MainTestView(aksara: ["M","i","u","M","e"])
}
