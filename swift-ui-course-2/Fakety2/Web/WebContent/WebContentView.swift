//
//  WebContentView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 20/02/25.
//

import SwiftUI

struct WebContentView: View {
    @State var data: String = ""

    let sessionDelegate = SessionDelegate()

    var body: some View {
        ScrollView {
            VStack {
                Text("URLSession")
                Button("get data") {
                    getData()
                }
                .buttonStyle(.borderedProminent)
                Button("get json") {
                    getJson()
                }
                .buttonStyle(.borderedProminent)
                Text(data)
            }
            .padding()
        }
    }

    func getData() {
        Task(priority: .background) {
            let session = URLSession.shared
//            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/ditto")!
            let url = URL(string: "https://www.yahoo.com")!

            do {
                let (data, response) = try await session.data(from: url, delegate: sessionDelegate)

                if let httpResponse = response as? HTTPURLResponse {
                    print("status code: \(httpResponse.statusCode)")

                    if httpResponse.statusCode == 200 {
                        if let content = String(data: data, encoding: .utf8) {
                            await MainActor.run { self.data = "\(content.count)" }
                        }
                    }
                }
            } catch {
                debugPrint("There was an error: \(error)")
            }
        }
    }

    func getJson() {
        Task(priority: .background) {
            let session = URLSession.shared
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

            do {
                let (data, response) = try await session.data(from: url, delegate: sessionDelegate)

                if let httpResponse = response as? HTTPURLResponse {
                    print("status code: \(httpResponse.statusCode)")

                    if httpResponse.statusCode == 200 {
                        let decoder = JSONDecoder()
                        let json = try? decoder.decode([PostSvModel].self, from: data)

                        await MainActor.run { self.data = String(describing: json) }
                    }
                }
            } catch {
                debugPrint("There was an error: \(error)")
            }
        }
    }
}

#Preview {
    WebContentView()
}
