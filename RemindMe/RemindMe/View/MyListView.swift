//
//  MyListView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 11/12/24.
//

import SwiftUI

struct MyListView: View {
    let myList: FetchedResults<MyList>

    var body: some View {
        NavigationStack {
            if myList.isEmpty {
                Spacer()
                Text("No reminders found")
            } else {
                ForEach(myList) { list in
                    VStack {
                        MyListListTileView(myList: list)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                            .padding([.leading], 10)
                            .font(.title3)
                        Divider()
                    }
                }
            }
        }
    }
}

// #Preview {
//    MyListView()
// }
