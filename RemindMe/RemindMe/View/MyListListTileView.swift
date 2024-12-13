//
//  MyListListTileView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 11/12/24.
//

import SwiftUI

struct MyListListTileView: View {
    let myList: MyList

    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundColor(Color(myList.color))
            Text(myList.name)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .opacity(0.75)
                .padding([.trailing], 10)
        }
    }
}

#Preview {
    MyListListTileView(myList: PreviewData.myList)
}
