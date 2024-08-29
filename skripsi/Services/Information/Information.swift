//
//  Information.swift
//  skripsi
//
//  Created by Rival Fauzi on 23/01/24.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black, lineWidth: 1)
                    .frame(height: 144)
                
                Text("Hai! aku Mas Jago\n\ndi sini kamu akan belajar aksara dengan cara yang menyenangkan!")
                    .font(.system(size: 16, weight: .regular))
                    .padding(.leading, 160)
                
                Image("quizCharacterSmile")
                    .resizable()
                    .frame(width: 149, height: 190)
            }
            
            Text("Caranya,")
                .font(.system(size: 16, weight: .bold))
                .padding(.vertical)
            
            Section {
                Text("1. Pilih modul yang ingin kamu pelajari")
                    .font(.system(size: 16, weight: .bold))
                
                SectionCardsMainView(title: "Carakan - Bagian 1", content: "ancrk")
                    .padding(.bottom)
            }
            
            Section {
                Text("2. Belajar bentuk dan pengucapan aksara")
                    .font(.system(size: 16, weight: .bold))
                
                InfoSectionCards(section: 0, char: AksaraInfoModel(characterString: "a", name: "ha", description: "Hari"))
                    .shadow(color: Color.color777777.opacity(0.1), radius: 4, x: 0, y: 4)
                    .disabled(true)
                    .padding(.bottom)
            }
            
            Section {
                Text("3. Mulai latihan dengan beragam soal")
                    .font(.system(size: 16, weight: .bold))
                
                Text("Seperti mengenali, menggambar, serta menyusun aksara. Perlu diketahui juga bahwa setiap soal memiliki waktu yang berbeda-beda.")
                    .font(.system(size: 16, weight: .regular))
                    .padding(.vertical, 1)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Panduan Bermain")
    }
}

#Preview {
    InformationView()
}
