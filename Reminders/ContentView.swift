//
//  ContentView.swift
//  Reminders
//
//  Created by Manu on 10/09/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var newListShown: Bool = false
    
    var body: some View {
        NavigationView {
            ReminderListView()
                .navigationBarTitle("Reminders lists")
                .toolbar {
                    Button(action: {
                        self.newListShown.toggle()
                    }) {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $newListShown) {
                        ReminderListCreateView()
                            .environment(\.managedObjectContext, viewContext)
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
