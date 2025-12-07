//
//  StudentViewModel.swift
//  UniManage
//

import Combine
import SwiftUI

extension Color {
    static let uniPrimary = Color.indigo
    static let uniBackground = Color(uiColor: .systemGroupedBackground)
    static let uniCard = Color(uiColor: .secondarySystemGroupedBackground)
}

struct Student: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let major: String
    let gpa: Double
}

struct Course: Identifiable {
    let id = UUID()
    let title: String
    let code: String
    let icon: String
    let color: Color
    let examDate: Date
}

class StudentViewModel: ObservableObject {
    @Published var students: [Student] = []
    @Published var isLoading: Bool = false
    
    func loadData() {
        
        // MARK: = Error #1 Netwrok Delay
        self.isLoading = true
        let randomDelay = Double.random(in: 1.5...3.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
            self.students = [
                Student(name: "Alice Rodriguez", major: "Comp Sci", gpa: 3.8),
                Student(name: "Liam Smith", major: "Design", gpa: 3.2),
                Student(name: "Emma Wong", major: "Mathematics", gpa: 3.9)
            ]
            self.isLoading = false
        }
    }
    
    func boostGrade(for student: Student) {
        guard let index = students.firstIndex(where: { $0.id == student.id }) else { return }
        
        // BUG #4: THE PHANTOM UPDATE
        let newGPA = min(student.gpa + 0.1, 4.0)
        print("Simulating network call... Updated GPA to \(newGPA)")
    }
}
