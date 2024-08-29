//
//  MainTestView.swift
//  skripsi
//
//  Created by Rival Fauzi on 03/01/24.
//

import SwiftUI

struct MainTestView: View {
    @Environment(\.presentationMode) var presentationMode
    let aksara: [String]
    @State var progress: Float = 0.07
    @ObservedObject var viewModel: MainTestViewModel = MainTestViewModel()
    @State var questions: [TestLevelOneModel] = []
    @State var isCheck = true
    @State var questionIndex = 0
    @State var isFailed = false
    @State var isChoosenTrue = false
    @State var choosenAnswer = ""
    @State var testDone = false
    @State var backButton = false
    @State var timerMode: TimerMode = .stopped
    @State var timeElapsed: TimeInterval = 0.0
    @State var percentage: Double = 0.0
    @State var quizInfo: Bool = true
    @State var timeUp: Bool = false
    
    var stopWatch = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            if quizInfo {
                VStack {
                    HStack(spacing: 16) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            ZStack {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color(.systemGray2))
                            }
                            .frame(width: 25, height: 25)
                        })

                        ProgressBar(value: 1)
                            .frame(height: 16)
                        
                        HStack {
                            Image(systemName: "timer")
                            Text("7 detik")
                        }
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 92, height: 32)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.colorEA7D5A)
                        }
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black, lineWidth: 1)
                            .frame(height: 144)
                        
                        Text("Ingat! Kamu punya 5 detik untuk soal pilihan, 15 detik untuk soal gambar, dan 20 detik untuk soal merangkai.")
                            .padding(.leading, geometry.size.width * 0.4)
                            .padding(.trailing)
                        
                        Image("quizCharacterOneFinger")
                            .resizable()
                            .frame(width: 149, height: 190)
                            .offset(y: geometry.size.height * 0.06)
                    }
                    
                    Spacer()
                    
                    Button {
                        quizInfo.toggle()
                        timerMode = .running
                    } label: {
                        Text("Lanjutkan")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.color55DA42)
                                        .shadow(color: .color2FBE1A, radius: 0, x: 0, y: 3)
                                    
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.color55DA42)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.color2FBE1A, lineWidth: 1)
                                        )
                                }
                                .padding(1)
                            }
                    }

                }
                .padding()
            } else if testDone {
                withAnimation {
                    ResultView(
                        timerMode: $timerMode,
                        timeElapsed: $timeElapsed,
                        totalQuestion: questions.count,
                        percentage: Int(percentage)
                    )
                }
            } else {
                VStack(spacing: 8) {
                    HStack(spacing: 16) {
                        Button(action: {
                            if questionIndex == 0 {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                backButton = true
                                viewModel.stopCountdown()
                            }
                        }, label: {
                            ZStack {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color(.systemGray2))
                            }
                            .frame(width: 25, height: 25)
                        })

                        ProgressBar(value: CGFloat(viewModel.timeRemaining) / CGFloat(viewModel.maxTime))
                            .frame(height: 16)
                        
                        HStack {
                            Image(systemName: "timer")
                            Text("\(viewModel.timeRemaining) detik")
                        }
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 92, height: 32)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.colorEA7D5A)
                        }
                    }
                    if questions.isEmpty {
                        Text("loading")
                    } else {
                        HStack {
                            Text("Soal \(questionIndex + 1)")
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                            Spacer()
                        }
                        switch questions[questionIndex].level {
                        case 1:
                            TestOneView(isCheck: $isCheck, question: questions[questionIndex], choosenAnswer: $choosenAnswer)
                        case 2:
                            TestTwoView(mainTestViewModel: viewModel, isCheck: $isCheck, choosenAnswer: $choosenAnswer, question: questions[questionIndex])
                        case 3:
                            TestThreeView(choosenAnswer: $choosenAnswer, isCheck: $isCheck, isFailed: $isFailed, question: questions[questionIndex])
                        default:
                            EmptyView()
                        }
                        
                        if questions[questionIndex].level == 3 {
                            Button(action: {
                                if choosenAnswer == questions[questionIndex].name {
                                    isChoosenTrue = true
                                    viewModel.stopCountdown()
                                } else {
                                    questions.append(questions[questionIndex])
                                    isFailed = true
                                }
                            }, label: {
                                Text("Periksa Jawaban")
                                    .foregroundColor(isCheck ? Color.gray : .white)
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(isCheck ? Color(.systemGray5) : .color55DA42)
                                                .shadow(color: isCheck ? Color(.systemGray5) : .color2FBE1A, radius: 0, x: 0, y: 3)
                                            
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(isCheck ? Color(.systemGray5) : .color55DA42)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(isCheck ? Color(.systemGray5) : .color2FBE1A, lineWidth: 1)
                                                )
                                        }
                                        .padding(1)
                                    }
                            })
                            .disabled(isCheck)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            questions = viewModel.generateQuestion(aksara: aksara)
        }
        .onChange(of: quizInfo, perform: { _ in
            switch questions[questionIndex].level {
            case 1:
                viewModel.startCountdown(time: 5)
            case 2:
                viewModel.startCountdown(time: 15)
            case 3:
                viewModel.startCountdown(time: 20)
            default:
                viewModel.startCountdown(time: 5)
            }
        })
        .onChange(of: questionIndex, perform: { _ in
            switch questions[questionIndex].level {
            case 1:
                viewModel.startCountdown(time: 5)
            case 2:
                viewModel.startCountdown(time: 15)
            case 3:
                viewModel.startCountdown(time: 20)
            default:
                viewModel.startCountdown(time: 5)
            }
        })
        .onChange(of: isCheck) { newValue in
            if !newValue && questions[questionIndex].level != 3 {
                viewModel.stopCountdown()
                
                if questions[questionIndex].level != 2 {
                    if choosenAnswer == questions[questionIndex].name {
                        isChoosenTrue = true
                    } else {
                        questions.append(questions[questionIndex])
                        isFailed = true
                    }
                } else {
                    progress = Float(questionIndex + 1) / Float(questions.count)
                    isCheck = true
                    
                    if questionIndex + 1 < questions.count {
                        questionIndex = questionIndex + 1
                    } else {
                        percentage = Double(7) / Double(questions.count) * 100
                        testDone = true
                    }
                }
            }
        }
        .overlay {
            if isFailed {
                PopUpFailed(isFailed: $isFailed, choosenAnswer: $choosenAnswer, isCheck: $isCheck, questionIndex: $questionIndex, questionCount: questions.count, timeOut: $timeUp)
            } else if isChoosenTrue {
                PopUpTrue(isTrue: $isChoosenTrue, choosenAnswer: $choosenAnswer, isCheck: $isCheck, questionIndex: $questionIndex, testDone: $testDone, percentage: $percentage, questionCount: questions.count)
                    .onAppear {
                        progress = Float(questionIndex + 1) / Float(questions.count)
                    }
            } else if backButton {
                AlertView(backButton: $backButton)
            }
        }
        .onReceive(viewModel.$timeUp, perform: { value in
            if value && !questions.isEmpty {
                questions.append(questions[questionIndex])
                timeUp = true
                isFailed = true
            }
        })
        .onReceive(stopWatch) { _ in
            updateTime()
        }
        .background(Color.colorFCFCFC)
    }
    
    func updateTime() {
        if timerMode == .running {
            timeElapsed += 1
        }
    }
}

#Preview {
    MainTestView(aksara: ["a","n","c","r","k"])
}
