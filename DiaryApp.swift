//
//  DiaryApp.swift
//  Diary
//
//  Created by sina on 16.02.2024.
//

import SwiftUI

@main
struct DiaryApp: App {
    let persistenceController = PersistenceController.shared
    let alertView = AlertView()

    var body: some Scene {
        WindowGroup {
            ListOfDiary()
                .environmentObject(alertView)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
