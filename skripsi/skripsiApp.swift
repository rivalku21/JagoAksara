//
//  skripsiApp.swift
//  skripsi
//
//  Created by Rival Fauzi on 25/12/23.
//

import SwiftUI

@main
struct skripsiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.customFont, .custom("SFProRounded-Regular", size: 16))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
