//
//  InfoView.swift
//  skripsi
//
//  Created by Rival Fauzi on 02/01/24.
//

import SwiftUI

struct InfoView: View {
    var arrayAksara: InfoModel?
    var viewModel: InfoViewModel = InfoViewModel()
    
    init(section: Int) {
        let jsonData2 = readLocalJSONFile(forName: "NewInfoAksara")
        
        if let data = jsonData2 {
            if let record = infoDataParse(jsonData: data) {
                self.arrayAksara = record.filter{ $0.section == section }.first
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                Text(arrayAksara?.title ?? "")
                    .font(.system(size: 20, weight: .bold))
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        Text(arrayAksara?.description ?? "")
                            .lineSpacing(8)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if arrayAksara?.description2 != "" {
                            Text(arrayAksara?.description2 ?? "")
                                .lineSpacing(8)
                                .font(.system(size: 15, weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        if arrayAksara?.note != "" {
                            Text(arrayAksara?.note ?? "")
                                .lineSpacing(8)
                                .font(.system(size: 15, weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        if arrayAksara?.note2 != "" {
                            Text(arrayAksara?.note2 ?? "")
                                .lineSpacing(8)
                                .font(.system(size: 15, weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        ForEach(arrayAksara?.text ?? [], id: \.self) { char in
                            InfoSectionCards(section: arrayAksara?.section ?? 0, char: char)
                                .shadow(color: Color.color777777.opacity(0.1), radius: 4, x: 0, y: 4)
                        }
                    }
                }

                NavigationLink(destination: MainTestView(aksara: arrayAksara!.text.map{ $0.characterString })) {
                    Text("Mulai Latihan")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
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
            .padding()
            .background(Color.colorFCFCFC)
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    InfoView(section: 1)
}
