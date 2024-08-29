//
//  CardComponent.swift
//  skripsi
//
//  Created by Rival Fauzi on 25/12/23.
//

import SwiftUI

struct TitleCardsMainView: View {
    var title: String
    var textBody: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                Text(textBody)
                    .bold()
            }
            .padding()
            
            Spacer()
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.color74C4F4)
                .shadow(color: .color4FA9E0, radius: 0, x: 0, y: 3)
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(.color74C4F4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.color4FA9E0, lineWidth: 1)
                    )
            }
            .padding(1)
        }
    }
}

struct SectionCardsMainView: View {
    let title: String
    var content: String
    var rectangleBackgroundColor = Color(.buttonBlue)

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.system(size: 12, weight: .regular))
                
                HStack {
                    if content.count > 5 {
                        ForEach(Array(content), id: \.self) {char in
                            if char != " " {
                                if "HSP".contains(char) {
                                    Text(String(char))
                                        .font(.custom("HanacarakaNormal", size: 26))
                                        .padding(.trailing)
                                } else {
                                    Image("\(char)")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 26)
                                }
                            }
                        }
                    } else {
                        Text(content)
                            .font(.custom("HanacarakaNormal", size: 26))
                    }
                }
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 26)
        }
        .foregroundColor(.black)
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.color74C4F4)
                .shadow(color: .gray, radius: 0, x: 0, y: 3)
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 1)
                    )
            }
            .padding(1)
        }
    }
}

extension SectionCardsMainView {
    func rectangleBackgroundColor(_ color: Color) -> Self {
        var view = self
        view.rectangleBackgroundColor = color
        return view
    }
}

struct SandhanganCardsMainView: View {
    var content: String
    var rectangleBackgroundColor = Color(.buttonBlue)

    var body: some View {
        HStack(spacing: 16) {
            HStack {
                Text(content)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 26)
            }
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.color74C4F4)
                    .shadow(color: .gray, radius: 0, x: 0, y: 3)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1)
                        )
                }
                .padding(1)
            }
        }
    }
}

extension SandhanganCardsMainView {
    func rectangleBackgroundColor(_ color: Color) -> Self {
        var view = self
        view.rectangleBackgroundColor = color
        return view
    }
}

struct InfoSectionCards: View {
    let section: Int
    let exception = "NCRKFTWLDJYVMGBQZeiuh=\\"
    let char: AksaraInfoModel
    
    var body: some View {
        HStack {
            Button(action: {
                playSound(name: char.name.capitalized)
            }, label: {
                ZStack {
                    ZStack(alignment: .bottomTrailing) {
                        RoundedRectangle(cornerRadius: 10)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 88, height: 88)
                            .foregroundColor(Color.colorE3F3FD)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 28, height: 28)
                                .foregroundColor(Color.color74C4F4)
                            
                            Image(systemName: "speaker.wave.2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12)
                                .foregroundColor(.white)
                        }
                        .offset(x: 14)
                    }
                    
                    if exception.contains(char.characterString) {
                        Image("\(char.characterString)")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .foregroundColor(.black)
                    } else if char.characterString == "[o" {
                        Image("\(char.characterString)")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .foregroundColor(.black)
                    } else if char.characterString == "/" {
                        Image("layar")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .foregroundColor(.black)
                    } else {
                        Text(char.characterString)
                            .font(.custom("HanacarakaNormal", size: char.characterString.count == 1 ? 45 : char.characterString.count == 2 ? 37 : 30))
                            .foregroundColor(.black)
                            .padding(.trailing, 8)
                            .padding(.top, 8)
                    }
                }
                .frame(width: 100)
            })
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(char.name)
                        .font(.system(size: 15, weight: .bold))
                        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 2, y: 2)
                    if section > 4 && ((char.example?.isEmpty) != nil) {
                        VStack(spacing: 16) {
                            HStack {
                                Text("\(char.description) :")
                                    .font(.system(size: 15, weight: .regular))
                                Spacer()
                            }
                            HStack {
                                Text(char.example!)
                                    .font(.custom("HanacarakaNormal", size: 20))
                                Spacer()
                            }
                        }
                    } else {
                        Text("Seperti dalam kata “\(Text(char.description).bold())”")
                            .font(.system(size: 15))
                    }
                }
                .padding()
                
                Spacer()
            }
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.white)
        }
    }
}

#Preview {
//    SectionCardsMainView(title: "Carakan I Bagian 1", content: "H    N    C    R     K")
//    TitleCardsMainView(title: "Carakan 1", textBody: "Belajar aksara jawa dasar yang memiliki vokal \"a\"")
    
    InfoSectionCards(section: 1, char: AksaraInfoModel(characterString: "i", name: "-i (wulu)", description: "hidup", example: "aifup\\"))
}

struct CircleProgress: View {
    let percentage: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(.systemGray5).opacity(0.55),
                    lineWidth: 10)
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(
                    Color(.customBlue), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .animation(Animation.easeInOut(duration: 1.0))
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 26)
                .foregroundColor(.customBlue)
        }
        .padding(.leading, 10)
        .frame(width: 50)
    }
}
