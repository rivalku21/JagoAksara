//
//  TestOneView.swift
//  skripsi
//
//  Created by Rival Fauzi on 02/01/24.
//

import SwiftUI

struct TestOneView: View {
    @Binding var isCheck: Bool
    var question: TestLevelOneModel
    let viewModel: TestOneViewModel = TestOneViewModel()
    @State var randomAnswer: [String] = []
    @Binding var choosenAnswer: String
    
    let exception = "NCRKFTWLDJYVMGBQZeiuh=\\"
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 16) {
                Text("Suara apa yang dihasilkan?")
                    .font(.headline)
                
                VStack(spacing: 24) {
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            ZStack {
                                ZStack(alignment: .bottomTrailing) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.black, lineWidth: 1)
                                        .frame(width: 342, height: 144)
                                    
                                    Image(systemName: "speaker.wave.2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 28)
                                        .padding(16)
                                        .foregroundStyle(.gray)
                                }
                                
                                HStack {
                                    Image("quizCharacterWithBatik")
                                        .resizable()
                                        .frame(width: 129, height: 166)
                                        .offset(x: 10, y: -11)
                                        .padding()
                                        .padding(.trailing)
                                    
                                    if exception.contains(question.characterString) {
                                        Image("\(question.characterString)")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 60)
                                            .foregroundColor(.black)
                                    } else if question.characterString == "[o" {
                                        Image("\(question.characterString)")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 50)
                                            .foregroundColor(.black)
                                    } else if question.characterString == "/" {
                                        Image("layar")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 50)
                                            .foregroundColor(.black)
                                    } else {
                                        Text(question.characterString)
                                            .font(.custom("HanacarakaNormal", size: 64))
                                            .padding(.trailing, 16)
                                    }
                                    
                                    Spacer()
                                }
                            }
                            .foregroundColor(.black)
                        }
                        .frame(width: geometry.size.width * 0.4)
                        
                        Spacer()
                    }
                    .padding(.bottom, geometry.size.height * 0.08)
                    
                    ForEach(randomAnswer, id:\.self) { ans in
                        Button(action: {
                            choosenAnswer = ans
                            isCheck = false
                        }, label: {
                            HStack {
                                Spacer()
                                ZStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(choosenAnswer == ans ? .colorE3F3FD : .white)
                                            .shadow(color: choosenAnswer == ans ? .color74C4F4 : Color(.systemGray5), radius: 0, x: 0, y: 3)
                                        
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(choosenAnswer == ans ? .colorE3F3FD : .white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(choosenAnswer == ans ? .color74C4F4 : Color(.systemGray5), lineWidth: 1)
                                            )
                                    }
                                    .padding(1)
                                    
                                    Text(ans.capitalized)
                                        .foregroundColor(choosenAnswer == ans ? .customBlue : .black)
                                }
                                Spacer()
                            }
                        })
                        .frame(height: geometry.size.height * 0.09)
                    }
                }
                
                Spacer()
            }
        }
        .onAppear {
            randomAnswer = viewModel.generateRandomAnswer(listAnswer: question.answer, answer: question.name)
        }
        .onChange(of: question) { newValue in
            randomAnswer = viewModel.generateRandomAnswer(listAnswer: newValue.answer, answer: newValue.name)
        }
    }
}

#Preview {
//    TestOneView()
    MainTestView(aksara: ["a","n","c","r","k"])
}
