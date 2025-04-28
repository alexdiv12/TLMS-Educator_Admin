//
//  CoursesView.swift
//  EduMatrix Admin
//
//  Created by Ankit Rajput on 04/07/24.
//

import SwiftUI

struct CoursesView: View {
    // Example course data
    @Binding var courses: [Course1]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: -20) {
                ForEach(courses) { course in
                    CourseCardView(course: course, onUpdate: { updatedEducator in
                        if let index = courses.firstIndex(where: { $0.id == updatedEducator.id }) {
                            courses.remove(at: index)
                        }
                    })
                        .padding(.horizontal, -3)
                }
            }
            .padding([.top, .bottom], -5)
            .background(Color.clear) // Ensure background is clear to avoid overlapping issues
        }
    }
}

//struct CoursesView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoursesView()
//    }
//}
