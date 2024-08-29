//
//  ResultView.swift
//  skripsi
//
//  Created by Rival Fauzi on 23/01/24.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var firstAppeared = false
    
    let imageNames = ["Image3", "Image5", "Image7", "Image9", "Image12","Image13", "Image14"]
    @State private var selectedImage: String?
    
    @Binding var timerMode: TimerMode
    @Binding var timeElapsed: TimeInterval
    let totalQuestion: Int
    let percentage: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Image("resultCharacter")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(height: 206)
                    .padding()
                
                Text("Latihan Selesai!")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack {
                    HStack {
                        VStack {
                            Text("\(totalQuestion)")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Aktivitas")
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(Color.color1F81BB)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.color1F81BB , lineWidth: 1)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("\(percentage)%")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Berhasil")
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(Color.color59CC01)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.color59CC01 , lineWidth: 1)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("\(timeElapsed.formattedSeconds())")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Waktu")
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(Color.red)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.red , lineWidth: 1)
                        }
                    }
                    .padding(.top)
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
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
                })
            }
        }
        .padding()
        .onAppear {
            selectedImage = imageNames.randomElement()
            timerMode = .stopped
        }
    }
}

#Preview {
    ResultView(timerMode: .constant(.stopped), timeElapsed: .constant(100.0), totalQuestion: 10, percentage: 100)
}
