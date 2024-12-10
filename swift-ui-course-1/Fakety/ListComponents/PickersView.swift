//
//  PickersView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 18/10/24.
//

import SwiftUI

struct PickersView: View {
    @State private var selected: String = "No value"
    let cities: [String] = ["Paris", "Toronto", "Dublin"]

    @State private var date: Date = Date()

    @State private var dates: Set<DateComponents> = []
    @State private var myDates: String = ""

    var body: some View {
        ScrollView {
            VStack {
                Text(selected)
                Picker("Cities:", selection: $selected) {
                    ForEach(cities, id: \.self) { city in
                        Text(city)
                        //                        .tag(index) // Can also use a list of indices and assign a tag to this view
                    }
                }
                .pickerStyle(.wheel)
                Text(date.formatted(.dateTime.weekday().day().month().year()))
                DatePicker("Date:", selection: $date, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.wheel)
                Text(myDates)
                MultiDatePicker("Dates:", selection: $dates)
            }
            .onAppear {
                selected = cities[0]
            }
            .onChange(of: dates, initial: false) { _, new in
                let days = new.map({ String($0.day!) })
                myDates = days.joined(separator: ",")
            }
        }
    }
}

#Preview {
    PickersView()
}
