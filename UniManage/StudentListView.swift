//
//  StudentListView.swift
//  UniManage
//
//

import SwiftUI

struct StudentListView: View {
    @StateObject var viewModel = StudentViewModel()
    @State private var searchText = ""

       var filteredStudents: [Student] {
           if searchText.isEmpty {
               return viewModel.students
           } else {
               return viewModel.students.filter { $0.name.contains(searchText) }
           }
       }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.uniBackground.ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView("Fetching Records...")
                } else if viewModel.students.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Button("Load Database") {
                            viewModel.loadData()
                        }
                        .padding()
                        .background(Color.uniPrimary)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .accessibilityIdentifier("LoadButton")
                    }
                } else {
                    List {
                        ForEach(filteredStudents) { student in
                            StudentRow(student: student) {
                                // Action when Badge is tapped
                                viewModel.boostGrade(for: student)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .accessibilityIdentifier("StudentList")
                }
            }
            .navigationTitle("Roster")
        }
    }
}

struct StudentRow: View {
    let student: Student
    var onBonusTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 50, height: 50)
                .overlay(Text(student.name.prefix(1)).foregroundColor(.white).font(.headline))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(student.name)
                    .font(.headline)
                Text(student.major)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onBonusTapped) {
                HStack(spacing: 4) {
                    Text(String(format: "%.1f", student.gpa))
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.caption)
                }
                .fontWeight(.bold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(student.gpa >= 3.5 ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                .foregroundColor(student.gpa >= 3.5 ? .green : .orange)
                .clipShape(Capsule())
            }
            .accessibilityIdentifier("GPA_\(student.name)")
            .buttonStyle(.plain)
        }
        .padding()
        .background(Color.uniCard)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .padding(.vertical, 4)
    }
}
