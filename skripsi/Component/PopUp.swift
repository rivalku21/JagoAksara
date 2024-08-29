//
//  PopUp.swift
//  skripsi
//
//  Created by Rival Fauzi on 23/01/24.
//

import Foundation
import SwiftUI

struct PopUpFailed: View {
    @Binding var isFailed: Bool
    @Binding var choosenAnswer: String
    @Binding var isCheck: Bool
    @Binding var questionIndex: Int
    let questionCount: Int
    @Binding var timeOut: Bool
    
    @State var isMoved = false
    
    var body: some View {
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack {
                        Spacer()
                        VStack {
                            HStack {
                                Image(systemName: timeOut ? "clock.fill" : "x.circle.fill")
                                Text(timeOut ? "Waktu Habis" : "Salah")
                                    .font(.system(size: geometry.size.height * 0.04))
                                .fontWeight(.bold)
                                Spacer()
                            }
                            .padding(.top)
                            .padding(.horizontal)
                            
                            HStack {
                                Text(timeOut ? "Ayo coba lagi, tapi lebih cepat ya!" : "Yaah, Jawaban kamu belum tepat nih")
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            Spacer()
                            Button {
                                withAnimation {
                                    isMoved = false
                                }
                                
                                choosenAnswer = ""
                                isCheck = true
                                questionIndex = questionIndex + 1
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    isFailed = false
                                    timeOut = false
                                }
                                
                            } label: {
                                Text("Selanjutnya")
                                    .font(.system(size: geometry.size.height * 0.025))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 2, y: 2)
                                    }
                            }
                        }
                        .padding()
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width, height: geometry.size.width * 0.5, alignment: .center)
                        .cornerRadius(20)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 12.0)
                                    .fill(Color.white)
                                    .ignoresSafeArea()
                                RoundedRectangle(cornerRadius: 12.0)
                                    .fill(Color.red.opacity(0.2))
                                    .ignoresSafeArea()
                            }
                        )
                    }
                    .animation(Animation.easeIn(duration: 0.2), value: isMoved ? 1 : 0)
                    .onAppear{
                        isMoved = true
                    }
                    .offset(y: isMoved ? 0 : geometry.size.width * 0.5)
                }
            }
        }
    }
}

struct PopUpTrue: View {
    @Binding var isTrue: Bool
    @Binding var choosenAnswer: String
    @Binding var isCheck: Bool
    @Binding var questionIndex: Int
    @Binding var testDone: Bool
    @Binding var percentage: Double
    let questionCount: Int
    
    @State var isMoved = false
    
    var body: some View {
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack {
                        Spacer()
                        VStack {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                Text("Benar")
                                    .font(.system(size: geometry.size.height * 0.04))
                                .fontWeight(.bold)
                                Spacer()
                            }
                            .padding(.top)
                            .padding(.horizontal)
                            
                            HStack {
                                Text("Hebat! Jawaban kamu benar")
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            Spacer()
                            Button {
                                withAnimation {
                                    isMoved = false
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    isTrue = false
                                    choosenAnswer = ""
                                    isCheck = true
                                    
                                    if questionIndex + 1 < questionCount {
                                        questionIndex = questionIndex + 1
                                    } else {
                                        percentage = Double(7) / Double(questionCount) * 100
                                        testDone = true
                                    }
                                }
                            } label: {
                                Text("Selanjutnya")
                                    .font(.system(size: geometry.size.height * 0.025))
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
                        .foregroundColor(.green)
                        .frame(width: geometry.size.width, height: geometry.size.width * 0.5, alignment: .center)
                        .cornerRadius(20)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 12.0)
                                    .fill(Color.white)
                                    .ignoresSafeArea()
                                RoundedRectangle(cornerRadius: 12.0)
                                    .fill(Color.green.opacity(0.2))
                                    .ignoresSafeArea()
                            }
                        )
                    }
                    .animation(Animation.easeIn(duration: 0.2), value: isMoved ? 1 : 0)
                    .onAppear{
                        isMoved = true
                    }
                    .offset(y: isMoved ? 0 : geometry.size.width * 0.5)
                }
            }
        }
    }
}

struct AlertView : View{
    @Binding var backButton: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack {
                        Spacer()
                        Text("Apakah kamu yakin meninggalkan progress?")
                            .font(.system(size: geometry.size.height * 0.03))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        HStack {
                            Button {
                                backButton = false
                            } label: {
                                Text("Kembali")
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Ya")
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.red)
                            }
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                        }
                    }
                    .padding()
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.5, alignment: .center)
                    .cornerRadius(20)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12.0)
                                .fill(Color.white)
                                .ignoresSafeArea()
                        }
                    )
                }
            }
        }
    }
}

#Preview {
//    MainTestView(aksara: "ancrk")
    AlertView(backButton: .constant(true))
}
