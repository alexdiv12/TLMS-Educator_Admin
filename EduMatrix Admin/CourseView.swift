//
//  CourseView.swift
//  EduMatrix Admin
//
//  Created by Ankit Rajput on 15/07/24.
//

import Foundation
import SwiftUI

struct CourseView: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: course.imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // A loading indicator while the image is being fetched
                            .frame(width: 280, height: 150)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 280, height: 150)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    case .failure:
                        Image("reload") // A placeholder image in case of failure
                            .resizable()
                            .frame(width: 280, height: 150)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    @unknown default:
                        Image("reload")
                            .resizable()
                            .frame(width: 280, height: 150)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                }
            }
            VStack(alignment:.leading){
                Text(course.name)
                    .font(.headline)
                    .padding(.top, 5)
                Text(course.educatorName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Text(course.price)
                        .font(.headline)
                    Spacer()
                    Text(String(format: "%.1f", course.averageRating))
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                HStack {
                    Image(systemName: "clock.fill")
                    Text(course.duration)
                    Image(systemName: "book.fill")
                    Text("\(course.videos.count ?? 0) Lessons")
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding(.horizontal,4)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .frame(width: 300)
    }
}
//struct CourseView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseView(course: Course(
//            id: "1",
//            educatorEmail : "email",
//            educatorName: "Virag",
//            name: "Web Development",
//            description: "Learn web development from scratch.",
//            duration: "12h 52m",
//            language: "English",
//            price: "Rs.1,500",
//            category: "Coding",
//            averageRating: 4.0,
//            keywords: "web, development",
//            imageUrl: "https://example.com/web_dev.png",
//            videos: [Video(id: UUID(), title: "Intro", url: URL(string: "https://example.com/intro.mp4")!)],
//            notes: [Note(id: UUID(), title: "Note 1", url: URL(string: "https://example.com/note1.pdf")!)]
//        ))
//    }
//}
