//
//  ListNotesApp.swift
//  ListNotes
//
//  Created by students on 13/9/47.
//

import SwiftUI
import SwiftData
@main
struct ListNotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Listt.self)
        }
    }
}
