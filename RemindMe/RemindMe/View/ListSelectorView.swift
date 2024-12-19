//
//  ListSelectorView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 16/12/24.
//

import SwiftUI

struct ListSelectorView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListFetchedResults: FetchedResults<MyList>
    
    @Binding var selectedList: MyList?

    var body: some View {
        List(myListFetchedResults) { myList in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundColor(Color(myList.color))
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle()) // Needeed to make the entire HStack clickable
                .onTapGesture {
                    print("hey")
                    selectedList = myList
                }
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    ListSelectorView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext,
                      CoreDataProvider.shared.persistentContainer.viewContext)
}
