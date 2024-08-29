//
//  TestTwoView.swift
//  skripsi
//
//  Created by Rival Fauzi on 03/01/24.
//

import SwiftUI

struct Drawing: Identifiable, Equatable {
    var id = UUID()
    var path: Path
    var color: Color
    var lineWidth: CGFloat
}

struct TestTwoView: View {
    @ObservedObject var mainTestViewModel: MainTestViewModel
    @Binding var isCheck: Bool
    @Binding var choosenAnswer: String
    var question: TestLevelOneModel
    let viewModel: TestTwoViewModel = TestTwoViewModel()
    
    @State private var drawnImage: UIImage?
    @State private var predictions: String?
    
    @State private var drawing: [Drawing] = []
    @State private var currentPath: Path = Path()
    @State var indexAnswer = 0
    @State var allowHit = true
    
    var canvasPallet: some View {
        return Canvas { context, _ in
            context.stroke(currentPath, with: .color(.black), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let point = value.location
                    currentPath.addLine(to: point)
                }
                .onEnded { _ in
                    updateDrawnImage()
                    predictions = viewModel.classifyImage(drawnImage: drawnImage)
                    isSamePattern()
                    currentPath = Path()
                }
        )
        .frame(width: 299, height: 299)
        .allowsHitTesting(allowHit)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 16) {
                Text("Tulis aksara berikut")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    Button(action: {
                        playSound(name: question.name.capitalized)
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.2)
                                .foregroundColor(Color(.systemGray3))
                            
                            Image(systemName: "speaker.wave.2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 28)
                                .padding(16)
                        }
                    })
                    
                    VStack {
                        Text(question.characterString)
                            .font(.custom("HanacarakaNormal", size: 17))
                        
                        Text(question.name)
                            .font(.body)
                    }
                }
                
                HStack {
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(.systemGray3))
                        
                        DashedLine(dashLength: 5, dashGap: 3)
                                    .foregroundColor(.black)
                                    .frame(width: geometry.size.width, height: 1)
                                    .opacity(0.3)
                        
                        DashedLine(dashLength: 5, dashGap: 3)
                                    .foregroundColor(.black)
                                    .frame(width: geometry.size.width * 0.9, height: 1)
                                    .rotationEffect(.degrees(90))
                                    .opacity(0.3)
                        
                        Image("dashline-\(question.name)-\(indexAnswer)")
                            .resizable()
                            .aspectRatio(6/4, contentMode: .fit)
                            .frame(height: geometry.size.width * 0.25)
                            .offset(y: -10)
                        
                        canvasPallet
                    }
                    .frame(width: geometry.size.width * 0.7)
                    
                    Spacer()
                }
                .padding(.vertical, geometry.size.height * 0.05)
                
                HStack {
                    Spacer()
                    Text("\(indexAnswer) / \(question.answer.count)")
                        .font(.subheadline)
                    Spacer()
                }
                
                Spacer()
            }
        }
        .onChange(of: indexAnswer) { newValue in
            if newValue != 0 {
                mainTestViewModel.addTime()
            }
        }
        .onChange(of: question) { newValue in
            indexAnswer = 0
            allowHit = true
        }
    }
    
    func updateDrawnImage() {
        drawnImage = canvasPallet.snapshot()
    }
    
    func isSamePattern() {
        guard let predictions = predictions else {
            return
        }
        
        let stringAnswer = question.answer[indexAnswer]
        var isContain = false
        
        if stringAnswer == "" {
            if predictions == stringAnswer {
                isContain = true
            }
        } else {
            for char in stringAnswer {
                if predictions.contains(char) {
                    isContain = true
                    break
                }
            }
        }
        
        if isContain {
            let lastQuestion = question.answer.count - 1
            if indexAnswer < lastQuestion {
                indexAnswer += 1
            } else {
                allowHit = false
                indexAnswer += 1
                isCheck = false
                mainTestViewModel.stopCountdown()
            }
        } else {
            triggerImpactFeedback()
        }
    }
    
    func triggerImpactFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
}

#Preview {
//    TestTwoView()
    MainTestView(aksara: ["a","n","c","r","k"])
}

struct DashedLine: Shape {
    var dashLength: CGFloat
    var dashGap: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let count = rect.width / (dashLength + dashGap)

        for i in 0 ..< Int(count) {
            let startX = CGFloat(i) * (dashLength + dashGap)
            let line = Path(CGRect(x: startX, y: 0, width: dashLength, height: rect.height))
            path.addPath(line)
        }

        return path
    }
}
