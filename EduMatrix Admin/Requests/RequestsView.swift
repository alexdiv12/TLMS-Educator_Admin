

import SwiftUI
import FirebaseFirestore

struct RequestsView: View {
    @State private var selectedSegment = 0
    @State private var educators: [Educator] = []
    @State private var courses: [Course1] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select a section", selection: $selectedSegment) {
                    Text("Educators").tag(0)
                    Text("Courses").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .padding(.horizontal, 15)
                
                if selectedSegment == 0 {
                                      // EducatorsListView(educators: educators, onApprove: approveEducator, onReject: rejectEducator)
                    EducatorsListView(educators: $educators)
                } else {
                    CoursesView(courses: $courses)
                }
            }
            .navigationTitle("Requests") // Set navigation title here
        }
        .onAppear(perform: {
            fetchEducators()
            fetchCourses()
        })
    }
    func fetchEducators() {
        let db = Firestore.firestore()
        db.collection("educatorsRequests").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            educators = documents.map { doc -> Educator in
                let data = doc.data()
                return Educator(
                    id: doc.documentID,
                    fullName: data["fullName"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    mobileNumber: data["mobileNumber"] as? String ?? "",
                    qualification: data["qualification"] as? String ?? "",
                    experience: data["experience"] as? String ?? "",
                    subjectDomain: data["subjectDomain"] as? String ?? "",
                    language: data["language"] as? String ?? "",
                    aadharImageURL: data["aadharImageURL"] as? String ?? "",
                    profileImageURL: data["profileImageURL"] as? String ?? "",
                    about: data["about"] as? String ?? ""
                )
            }
        }
    }
    func fetchCourses() {
        let db = Firestore.firestore()
        db.collection("coursesRequests").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            courses = documents.compactMap { doc in
                let data = doc.data()
                
                // Decode videos
                var videos = [Video]()
                if let videosData = data["videos"] as? [[String: Any]] {
                    videos = videosData.compactMap { videoData in
                        guard let idString = videoData["id"] as? String,
                              let id = UUID(uuidString: idString),
                              let title = videoData["title"] as? String,
                              let videoURLString = videoData["videoURL"] as? String,
                              let videoURL = URL(string: videoURLString) else { return nil }
                        return Video(id: id, title: title, videoURL: videoURL)
                    }
                }
                
                // Create the course object
                return Course1(
                    id: data["id"] as? String ?? "",
                    educatorEmail: data["educatorEmail"] as? String ?? "",
                    educatorName: data["educatorName"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    description: data["description"] as? String ?? "",
                    duration: data["duration"] as? String ?? "",
                    language: data["language"] as? String ?? "",
                    price: data["price"] as? String ?? "",
                    category: data["category"] as? String ?? "",
                    averageRating: data["averageRating"] as? Double ?? 0.0,
                    keywords: data["keywords"] as? String ?? "",
                    imageUrl: data["imageUrl"] as? String ?? "",
                    videos: videos,
                    notes: nil
                )
            }
        }
    }
}

//struct RequestsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestsView()
//    }
//}


 




