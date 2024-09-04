//
//  HowUseSwiftDatainSwiftUIPreviewsApp.swift
//  HowUseSwiftDatainSwiftUIPreviews
//
//  Created by Hakob Ghlijyan on 04.09.2024.
//

import SwiftUI
import SwiftData

@main
struct HowUseSwiftDatainSwiftUIPreviewsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self)
        }
    }
}
