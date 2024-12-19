//
//  MyListDetailView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 12/12/24.
//

import SwiftUI

struct MyListDetailView: View {
    @FetchRequest(sortDescriptors: [])
    private var reminderFetchedResults: FetchedResults<Reminder>

    @State private var openAddReminder: Bool = false
    @State private var title: String = ""

    private var isFormValid: Bool { !title.isEmpty }

    let myList: MyList

    init(myList: MyList) {
        self.myList = myList
        
        _reminderFetchedResults = FetchRequest(
            fetchRequest: ReminderService.getRemindersByList(myList: myList)
        )
    }

    var body: some View {
        VStack {
            ReminderListView(reminders: reminderFetchedResults)
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New reminder") {
                    openAddReminder = true
                }
            }
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .alert("New reminder", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {}
            Button("Done") {
                if isFormValid {
                    do {
                        try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)

                    } catch {
                        print("Error saving reminder: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
