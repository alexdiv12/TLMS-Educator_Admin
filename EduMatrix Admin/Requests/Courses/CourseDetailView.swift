import SwiftUI
import FirebaseFirestore
import AVKit

struct CourseDetailView: View {
    var course: Course1
    var onUpdate: (Course1) -> Void
    @State private var videos: [Video] = []
    @State private var notes: [Note] = []
    @State private var showAlertConfirm = false
    @State private var showAlertReject = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Course Image
                if let url = URL(string: course.imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(12)
                }
                
                // Course Details
                VStack(alignment: .leading, spacing: 8) {
                    Text(course.name)
                        .font(.largeTitle)
                        .bold()
                    
                    Text("By \(course.educatorName)")
                        .font(.title2)
                    
                    Text(course.description)
                        .font(.body)
                    
                    Text("Category: \(course.category)")
                        .font(.body)
                    
                    Text("Duration: \(course.duration)")
                        .font(.body)
                    
                    Text("Price: \(course.price)")
                        .font(.body)
                    
                    // Educator Details
                    Text("Educator Email: \(course.educatorEmail)")
                        .font(.body)
                }
                .padding(.horizontal)
                
                // Course Content
                VStack(alignment: .leading, spacing: 8) {
                    Text("Course Lecture")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
//                    ForEach(course.videos) { video in
//                        VStack(alignment: .leading) {
//                            Text(video.title)
//                                .font(.headline)
//                            
//                            VideoPlayer(player: AVPlayer(url: video.url))
//                                .frame(height: 200)
//                                .cornerRadius(10)
//                        }
//                        .padding(.horizontal)
//                    }
                    
                    ForEach(course.videos) { video in
                        VStack(alignment: .leading) {
                            Text(video.title)
                                .font(.headline)
                            VideoPlayerView(videoURL: video.videoURL)                        }
                        .padding(.horizontal)
                    }
                }
                
                // Approve and Reject Buttons
                HStack {
                    Button(action: {
                        // Handle approve action
                        showAlertConfirm = true
                    }) {
                        Text("Approve")
                            .frame(width: 85, height: 28)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .alert(isPresented: $showAlertConfirm) {
                        Alert(
                            title: Text("Confirmation"),
                            message: Text("Do you want to approve the course request?"),
                            primaryButton: .default(Text("Yes")) {
                                print("approved")
                                approveCourse()
                            },
                            secondaryButton: .cancel(Text("No"))
                        )
                    }
                    .padding(.bottom, 5)
                    
                    Spacer()
                    
                    Button(action: {
                        // Handle reject action
                        showAlertReject = true
                    }) {
                        Text("Reject")
                            .frame(width: 85, height: 28)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .alert(isPresented: $showAlertReject) {
                        Alert(
                            title: Text("Rejection"),
                            message: Text("Do you want to reject the course request?"),
                            primaryButton: .default(Text("Yes")) {
                                print("Rejected")
                                rejectCourse()
                            },
                            secondaryButton: .cancel(Text("No"))
                        )
                    }
                    .padding(.bottom, 5)
                }
                .padding([.horizontal, .bottom])
            }
        }
        .onAppear {
            fetchCourseDetails()
        }
    }
    
    private func fetchCourseDetails() {
        let db = Firestore.firestore()
        
        // Fetch videos
        db.collection("courses").document(course.id).collection("videos").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching videos: \(error.localizedDescription)")
                return
            }
            self.videos = snapshot?.documents.compactMap {
                try? $0.data(as: Video.self)
            } ?? []
        }
        
        // Fetch notes
        db.collection("courses").document(course.id).collection("notes").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching notes: \(error.localizedDescription)")
                return
            }
            self.notes = snapshot?.documents.compactMap {
                try? $0.data(as: Note.self)
            } ?? []
        }
    }
    
    private func approveCourse() {
        print("Approved \(course.name)")
        let db = Firestore.firestore()
        db.collection("coursesRequests").document(course.id).delete()
        onUpdate(course)
        
        db.collection("courses").document(course.id).setData(course.toDictionary()) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Course added to Courses successfully")
            }
        }
    }
    
    private func rejectCourse() {
        print("Rejected \(course.name)")
        let db = Firestore.firestore()
        db.collection("coursesRequests").document(course.id).delete()
        onUpdate(course)
        
        db.collection("rejectedCourses").document(course.id).setData(course.toDictionary()) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Course added to rejected courses list")
            }
        }
    }
}

struct VideoPlayerView: View {
    let videoURL: URL

    var body: some View {
        VideoPlayer(player: AVPlayer(url: videoURL))
            .frame(height: 300)
    }
}
