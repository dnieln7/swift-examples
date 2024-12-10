//
//  TablesView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 17/10/24.
//

import SwiftUI

struct TablesView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    @State private var sortModes: [KeyPathComparator] = [KeyPathComparator(\ConsumableItem.name), KeyPathComparator(\ConsumableItem.calories)]
    @State private var selectedItems: Set<ConsumableItem.ID> = []

    var sortedItems: [ConsumableItem] {
        applicationData.listOfItems.sorted(using: sortModes)
    }

    var body: some View {
//        VStack {
//            EditButton()
//            Table(sortedItems, selection: $selectedItems, sortOrder: $sortModes) {
//                TableColumn("Name", value: \.name)
//                TableColumn("Category", value: \.category)
//                TableColumn("Calories") { item in
//                    Text("\(item.calories)")
//                }
//                TableColumn("Included", value: \.included, comparator: CompareBool()) { item in
//                    Toggle("", isOn: itemBinding(id: item.id).included)
//                        .labelsHidden()
//                }
//            }
//        }
//        .contextMenu(forSelectionType: ConsumableItem.ID.self, menu: { selected in
//            if selected.count <= 0 {
//                Button("Create new item") {
//                    let newItem = ConsumableItem(name: "New name", category: "New category", calories: 101, included: false)
//
//                    applicationData.listOfItems.append(newItem)
//                }
//            } else if selected.count == 1 {
//                Button("Remove item") {
//                    applicationData.listOfItems.removeAll(where: { $0.id == selected.first })
//                }
//            } else {
//                Button("Remove selected") {
//                    applicationData.listOfItems.removeAll(where: { selected.contains($0.id) })
//                }
//            }
//        })
        Table(
            of: ConsumableItem.self,
            columns: {
                TableColumn("Name", value: \.name)
                TableColumn("Category", value: \.category)
                TableColumn("Calories") { item in
                    Text("\(item.calories)")
                }
                .width(100)
            },
            rows: {
                TableRow(ConsumableItem(name: "STANDARD", category: "", calories: 0, included: false))
//                ForEach(applicationData.listOfItems)
                ForEach(applicationData.listOfItems) { item in
                    if item.calories <= 500 {
                        TableRow(item)
                    } else {
                        DisclosureTableRow(item) {
                            ForEach(applicationData.listOfItems)
                        }
                    }
                }
            }
        )
    }

    func listSelected() -> String {
        let list: [String] = selectedItems.map({ id in
            let item = applicationData.listOfItems.first(where: { $0.id == id })

            return item?.name ?? ""
        })

        return String(list.sorted().joined(separator: " | "))
    }

    func itemBinding(id: UUID) -> Binding<ConsumableItem> {
        let index = applicationData.listOfItems.firstIndex(where: { $0.id == id }) ?? 0

        return Bindable(applicationData).listOfItems[index]
    }
}

struct CompareBool: SortComparator {
    typealias Compared = Bool

    var order: SortOrder = .forward

    func compare(_ first: Bool, _ second: Bool) -> ComparisonResult {
        return if order == .forward && first && !second {
            .orderedAscending
        } else if order == .reverse && first && !second {
            .orderedDescending
        } else if order == .forward && !first && second {
            .orderedDescending
        } else {
            // if order == .reverse && !first && second
            .orderedAscending
        }
    }
}

#Preview {
    TablesView()
        .environment(ApplicationData())
}
