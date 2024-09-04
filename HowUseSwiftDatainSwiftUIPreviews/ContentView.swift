//
//  ContentView.swift
//  HowUseSwiftDatainSwiftUIPreviews
//
//  Created by Hakob Ghlijyan on 04.09.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: [SortDescriptor(\User.name, comparator: .localizedStandard)]) var users: [User]

    var body: some View {
        NavigationStack {
            List(users) { user in
                Text(user.name)
            }
        }
    }
}

struct EditingView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var user: User
    
    var body: some View {
        Form {
            Text(user.name)
        }
    }
}

//1
@MainActor
class DataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: User.self, configurations: config)

            for i in 1...9 {
                let user = User(name: "Example User \(i)")
                container.mainContext.insert(user)
            }

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}


//1
#Preview {
    ContentView()
        .modelContainer(DataController.previewContainer)
}

//2
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)

    for i in 1..<10 {
        let user = User(name: "Example User \(i)")
        container.mainContext.insert(user)
    }

    return ContentView()
        .modelContainer(container)
}

//3
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    let user = User(name: "Test User")
    
    return EditingView(user: user)
        .modelContainer(container)
}


@Model
class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

