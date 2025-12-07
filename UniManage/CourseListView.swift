//
//  CourseListView.swift
//  UniManage
//
//

import SwiftUI
struct CourseListView: View {
    let courses = [
        Course(title: "iOS Development", code: "CS401", icon: "iphone", color: .blue, examDate: Date()),
        Course(title: "UI/UX Design", code: "DS202", icon: "paintbrush", color: .purple, examDate: Date().addingTimeInterval(86400 * 2))
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // BUG 2: TimeZone Hardcoding
    // App displays UTC, but Test (and User) expects Local Time
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(courses) { course in
                        VStack(alignment: .leading, spacing: 12) {
                            Image(systemName: course.icon).font(.title2).foregroundColor(.white)
                            Text(course.title).font(.headline).foregroundColor(.white)
                            
                            Text("Exam: \(dateFormatter.string(from: course.examDate))")
                                .font(.caption2)
                                .padding(4)
                                .background(.black.opacity(0.2))
                                .cornerRadius(4)
                                .foregroundColor(.white)
                                .accessibilityIdentifier("ExamDate_\(course.code)")
                        }
                        .padding()
                        .background(course.color)
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("My Courses")
        }
    }
}

