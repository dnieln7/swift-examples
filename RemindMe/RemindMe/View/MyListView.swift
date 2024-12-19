//
//  MyListView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 11/12/24.
//

import SwiftUI

struct MyListView: View {
    let myLists: FetchedResults<MyList>

    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No reminders found")
            } else {
                ForEach(myLists) { list in
                    VStack {
                        NavigationLink(value: list) {
                            MyListListTileView(myList: list)
                                .frame(maxWidth:.infinity, alignment: .trailing)
                                .padding([.leading], 10)
                                .font(.title3)
                        }
                        Divider()
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MyList.self) { list in
                    MyListDetailView(myList: list)
                        .navigationTitle(list.name)
                }
            }
        }
    }
}

// #Preview {
//    MyListView()
// }
