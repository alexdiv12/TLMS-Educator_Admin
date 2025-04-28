//
//  AllCoursesGridView.swift
//  EduMatrix Admin
//
//  Created by aaa on 18/07/24.
//

import Foundation
import SwiftUI
struct AllCoursesGridView: View {
    var courses: [Course1]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(courses) { course in
                    NavigationLink(destination: CourseDetailsView(course: course)) {
                        trendingCourseCardView(course: course)
                            .frame(maxWidth: .infinity, minHeight: 140)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.top, 16)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Courses")
    }
    
    struct CourseCardView: View {
        var course: Course
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                if let url = URL(string: course.imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 120)
                            .clipped()
                    } placeholder: {
                        Color.gray
                            .frame(height: 120)
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(course.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    Text("By \(course.educatorName)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    HStack(spacing: 3) {
                        Text(String(format: "%.1f ", course.averageRating))
                        ForEach(0..<5) { star in
                            Image(systemName: star < Int(course.averageRating) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                        
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
                    }
                    
                    Text("₹\(course.price)")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    //                if course.isBestSeller {
                    //                    Text("Bestseller")
                    //                        .font(.caption)
                    //                        .foregroundColor(.yellow)
                    //                        .padding(5)
                    //                        .background(Color.black)
                    //                        .cornerRadius(5)
                    //                }
                }
                .padding([.horizontal, .bottom])
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.vertical, 5)
        }
    }
    
    
    //struct CourseCardView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        CourseCardView(course: sampleCourses[0])
    //    }
    //}
    
    struct CourseDetailsView: View {
        var course: Course1
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: course.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(height: 200)
                .clipped()
                
                Text(course.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(course.description)
                    .font(.body)
                
                HStack {
                    Text("Duration: \(course.duration)")
                    Spacer()
                    Text("Language: \(course.language)")
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(course.name)
        }
    }
}

