//
//  MainView.swift
//  skripsi
//
//  Created by Rival Fauzi on 25/12/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .topTrailing) {
                    Image("batik-parang-kusumo")
                        .padding()
                    
                    NavigationLink {
                        InformationView()
                    } label: {
                        Circle()
                            .frame(height: 42)
                            .foregroundStyle(.colorEA7D5A)
                            .overlay {
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(height: 25)
                                    .foregroundColor(.white)
                                    .shadow(radius: 8)
                            }
                    }
                    .padding()

                    
                    VStack(spacing: 16) {
                        HStack(alignment: .center) {
                            Text("Ayo kita\nbelajar Aksara!")
                                .font(.title)
                                .bold()
                            Spacer()
                        }
                        .padding(.top, geometry.size.height * 0.15)
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 16) {
                                TitleCardsMainView(title: "Carakan I", textBody: "Belajar aksara jawa dasar yang memiliki vokal \"a\"")
                                
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 1)) {
                                        SectionCardsMainView(title: "Bagian 1", content: "ancrk")
                                    }
                                }
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 2)) {
                                        SectionCardsMainView(title: "Bagian 2", content: "ftswl")
                                    }
                                }
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 3)) {
                                        SectionCardsMainView(title: "Bagian 3", content: "pdjyv")
                                    }
                                }
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 4)) {
                                        SectionCardsMainView(title: "Bagian 4", content: "mgbqz")
                                    }
                                }
                                
                                TitleCardsMainView(title: "Sandhangan", textBody: "Belajar tanda diakritik yang dipakai sebagai pengubah bunyi.")
                                
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 5)) {
                                        SandhanganCardsMainView(content: "Sandhangan Swara")
                                    }
                                }
                                
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 6)) {
                                        SandhanganCardsMainView(content: "Sandhangan Panyigeg")
                                    }
                                }
                                
                                TitleCardsMainView(title: "Carakan II Aksara Pasangan", textBody: "Aksara penghubung suku kata tertutup konsonan dengan suku kata berikutnya")
                                
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 7)) {
                                        SectionCardsMainView(title: "Carakan II Bagian 1", content: "H N C R K")
                                    }
                                }
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 8)) {
                                        SectionCardsMainView(title: "Carakan II Bagian 2", content: "F T S W L")
                                    }
                                }
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 9)) {
                                        SectionCardsMainView(title: "Carakan II Bagian 3", content: "P D J Y V")
                                    }
                                }
                                HStack(spacing: 16) {
                                    NavigationLink(destination: InfoView(section: 10)) {
                                        SectionCardsMainView(title: "Carakan II Bagian 4", content: "M G B Q Z")
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                    .padding()
                }
            }
            .background(Color.colorFCFCFC)
        }
    }
}

#Preview {
    MainView()
}
