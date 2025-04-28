//
//  EducatorDetailsView.swift
//  EduMatrix Admin
//
//  Created by aaa on 18/07/24.
//

import Foundation
import SwiftUI
struct EducatorDetailsView: View {
    var educator: Educator
    
    var body: some View {
        ScrollView {
            VStack() {
                HStack {
                    if let url = URL(string: educator.profileImageURL) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(educator.fullName)
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.primaryColor)
                        Text("#1st Edumaster")
                            .foregroundColor(.gray)
                        Text(educator.subjectDomain)
                            .foregroundColor(.gray)
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                            Text("EduMatrix Verified")
                                .foregroundColor(.gray)
                        }
                        HStack(spacing: 5) {
                            ForEach(0..<4) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                            }
                            Image(systemName: "star")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal,20)
                .padding()
                
                GeometryReader { geometry in
                    HStack {
                        VStack {
                            Text("24 +")
                                .font(.title)
                                .bold()
                            Text("Courses")
                                .foregroundColor(.gray)
                        }
                        .frame(width: geometry.size.width / 3, height: geometry.size.height)
                       
                        
//                        Spacer()
                        
                        VStack {
                            Text("240 Hrs")
                                .font(.title)
                                .bold()
                            Text("Teaching")
                                .foregroundColor(.gray)
                        }
                        .frame(width: geometry.size.width / 3, height: geometry.size.height)
                        
                        
//                        Spacer()
                        
                        VStack {
                            Text(educator.experience)
                                .font(.title)
                                .bold()
                            Text("Experience")
                                .foregroundColor(.gray)
                        }
                        .frame(width: geometry.size.width / 3, height: geometry.size.height)
                        
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .frame(height: 120)
                .padding(.leading, 10)
                .padding(.trailing, 25)
                Text("About me")
                    .font(.headline)
                    .padding()
                
                Text("I am specialize in teaching students how to create three-dimensional models using software like Blender, Maya, or 3ds Max. They cover techniques in modeling, texturing, rendering, and animation, providing students with the skills needed to produce detailed and realistic 3D graphics for various applications such as video games, movies, and virtual reality.")
                    .padding(.horizontal)
                
                Text("Courses by \(educator.fullName)")
                    .font(.headline)
                    .padding()
                
                VStack(alignment: .leading) {
                    ForEach(0..<3) { _ in
                        HStack {
                            Image("course_image")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text("2D and 3D deployment")
                                    .font(.headline)
                                HStack(spacing: 5) {
                                    ForEach(0..<4) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.orange)
                                    }
                                    Image(systemName: "star")
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
