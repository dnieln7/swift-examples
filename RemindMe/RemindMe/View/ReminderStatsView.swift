//
//  ReminderStatsView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 19/12/24.
//

import SwiftUI

struct ReminderStatsView: View {
    @Environment(\.colorScheme) var mode

    let icon: String
    let iconColor: Color
    let title: String
    let count: Int?

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                        .font(.title)
                        .padding([.bottom], 4)
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(mode == .dark ? .white.opacity(0.10) : .black.opacity(0.10))
            .foregroundColor(mode == .dark ? .white : .black)
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        }
    }
}

#Preview {
    ReminderStatsView(
        icon: "calendar",
        iconColor: Color.red,
        title: "Reminders",
        count: 1
    )
}
