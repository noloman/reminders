//
//  RemindersApp.swift
//  Reminders
//
//  Created by Manu on 10/09/2021.
//

import SwiftUI

@main
struct RemindersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
