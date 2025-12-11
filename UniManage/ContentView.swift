import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StudentListView().tabItem { Label("Students", systemImage: "person.3") }
            CourseListView().tabItem { Label("Courses", systemImage: "books.vertical") }
            SettingsView().tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}
