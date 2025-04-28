//
//  EducatorDetailView.swift
//  EduMatrix Admin
//
//  Created by Ankit Rajput on 04/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct EducatorDetailView: View {
    var educator: Educator
    @State private var aadharImage : UIImage?
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                Text("Name: \(educator.fullName)")
                Text("Mail: \(educator.email)")
                Text("Phone: \(educator.mobileNumber)")
            }
            
            Section(header: Text("Professional Information")) {
                Text("Qualification: \(educator.qualification)")
//                Text("Skills: \(educator.skills)")
                Text("Experience: \(educator.experience)")
                Text("Subjects/Domains: \(educator.subjectDomain)")
                Text("Languages: \(educator.language)")
                Text("About: \(educator.about)")
            }
            
            if let image = aadharImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 373, height: 150)
            }
        }
        .onAppear {
            Services.loadImage(from: URL(string: educator.aadharImageURL)!){ image in
                self.aadharImage = image
            }
        }
        .navigationTitle("Educator Details")
    }
}

struct EducatorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let educator = Educator(
            fullName: "Alice Johnson",
            email: "alice.johnson@example.com",
            mobileNumber : "123-456-7890",
            qualification: "PhD in Mathematics",
            experience: "10 years",
            subjectDomain : "Mathematics",
            language: "English, Spanish",
            aadharImageURL: "admin_avatar",
            profileImageURL: "sdf",
            about: "Passionate about teaching and research in Mathematics."
        )
        EducatorDetailView(educator: educator)
    }
}
