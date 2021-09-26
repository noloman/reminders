//
//  ReminderListView.swift
//  Reminders
//
//  Created by Manu on 12/09/2021.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(red: Double.random(in: 0...1),
                     green: Double.random(in: 0...1),
                     blue: Double.random(in: 0...1))
    }
}

struct ReminderListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var reminderLists: FetchedResults<ReminderList>
    
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(reminderLists, id:\.self) { (reminderList: ReminderList) in
                        NavigationLink(destination: RemindersView(list: reminderList)) {
                            CircularImageView(color: Color.random)
                            Text(reminderList.title)
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
            }
            .toolbar {
                EditButton()
            }
            .listStyle(GroupedListStyle())
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        
    }
}

struct ReminderListView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView()
    }
}
