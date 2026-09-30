//
//  FilesHelper.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 25/12/24.
//

import Observation
import SwiftUI

@Observable class DummyFileManager {
    @ObservationIgnored private let fileManager: FileManager
    @ObservationIgnored private let directories: [URL]

    var dummyFiles: [DummyFile] = []

    private init() {
        print("initializing FilesHelper...")

        fileManager = FileManager.default
        directories = fileManager.urls(for: .documentDirectory, in: .userDomainMask)

        if let docsDirectoryURL = directories.first {
            if let files = try? fileManager.contentsOfDirectory(atPath: docsDirectoryURL.path) {
                
                print("files: \(files)")
                
                for file in files {
                    let dummyFile = DummyFile(name: file)
                    dummyFiles.append(dummyFile)
                }
                
                loadDefaultFile()
            }
        }
    }
    
    private func loadDefaultFile() {
        // Load file from main bundle
        
        let defaultFile = dummyFiles.first(where: {$0.name == "cat.txt"})
        
        if defaultFile != nil {
            return
        }
        
        if let filePath = Bundle.main.path(forResource: "cat", ofType: "txt"){
            if let contentData = fileManager.contents(atPath: filePath) {
                if let content = String(data: contentData, encoding: .utf8){
                    save(name: "cat", content: content)
                }
            }
        }
    }

    func save(name: String, content: String) {
        if let docsDirectoryURL = directories.first {
            let fileURL = docsDirectoryURL.appendingPathComponent(name + ".txt")
            let filePath = fileURL.path

            print("save fileURL: \(fileURL)")
            print("save path: \(filePath)")

            if let contentData = content.data(using: .utf8) {
                let success = fileManager.createFile(
                    atPath: filePath,
                    contents: contentData,
                    attributes: nil
                )

                if success {
                    let dummyFile = DummyFile(name: name + ".txt")
                    dummyFiles.append(dummyFile)
                }
            }
        }
    }

    func load(name: String) async -> String? {
        if let docsDirectoryURL = directories.first {
            let fileURL = docsDirectoryURL.appendingPathComponent(name)
            let filePath = fileURL.path
            
            print("load fileURL: \(fileURL)")
            print("load path: \(filePath)")

            if fileManager.fileExists(atPath: filePath) {
                if let contentData = fileManager.contents(atPath: filePath) {
                    return String(data: contentData, encoding: .utf8)
                }
            }
        }

        return nil
    }

    func delete(name: String) {
        if let docsDirectoryURL = directories.first {
            let fileURL = docsDirectoryURL.appendingPathComponent(name)
            let filePath = fileURL.path
            
            print("delete fileURL: \(fileURL)")
            print("delete path: \(filePath)")

            do {
                try fileManager.removeItem(atPath: filePath)
                dummyFiles.removeAll { $0.name == name }
            } catch {
                debugPrint("Error deleting file: \(error)")
            }
        }
    }

    static let shared: DummyFileManager = DummyFileManager()
}
