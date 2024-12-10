//
//  GroupsAndGridsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 07/10/24.
//

import SwiftUI

struct GroupsAndGridsView: View {
    var body: some View {
        VStack {
            // GroupBox views used to visually group related views and controls
            GroupBox {
                Text("This is the list of")
                Text("Cities")
            }
            // Group views used to style together or return one view with an if else
            Group {
                Text("This is the list of")
                Text("Cities")
            }.foregroundColor(.gray)
            Group {
                Text("Manchester")
                Text("Viena")
            }.font(.largeTitle)
            Grid {
                GridRow {
                    Color.red
                        .frame(width: 100, height: 100)
                    Color.yellow
                        .frame(width: 100, height: 100)
                }
                GridRow {
                    Color.blue
                        .frame(width: 100, height: 100)
                    Color.purple
                        .frame(width: 100, height: 100)
                }
                GridRow {
                    Color.green
                        .frame(width: 100, height: 100)
                }.gridCellColumns(2)
            }
        }
    }
}

#Preview {
    GroupsAndGridsView()
}
