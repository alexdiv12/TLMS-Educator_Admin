import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct CourseCardView: View {
    var course: Course1
    var onUpdate: (Course1) -> Void
    @State private var image : UIImage? = UIImage(named: "reload")  // Default placeholder image
    @State private var showAlertConfirm = false
    @State private var showAlertReject = false
    @State private var showDetailView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: image!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
                .cornerRadius(12)
            
            // Course Details
            HStack {
                VStack(alignment: .leading) {
                    Text(course.name)
                        .font(.headline)
                        .bold()
                    
                    Text("By \(course.educatorName)")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("₹ \(course.price)")
                        .font(.headline)
                        .bold()
                    
                    Text("Duration: \(course.duration) hrs")
                        .font(.subheadline)
                    //.bold()
                }
            }
            .padding([.horizontal, .top])
            
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
                        primaryButton: .default(Text("No")),
                        secondaryButton: .cancel(Text("Yes")){
                            print("approved")
                            approveCourse()
                        }
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
                        primaryButton: .default(Text("Yes")),
                        secondaryButton: .cancel(Text("No")){
                            print("Rejected")
                            rejectCourse()
                        }
                    )
                }
                .padding(.bottom, 5)
            }
            .padding([.horizontal, .bottom])
        }
        .onTapGesture {
            showDetailView = true
        }
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding()
        .sheet(isPresented: $showDetailView) {
            CourseDetailView(course: course ,onUpdate: onUpdate)
        }
        .onAppear{
            loadImage(from: URL(string: course.imageUrl)!)
        }
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding()
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image from \(url): \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
    
    
    
    private func approveCourse() {
        print("Approved \(course.name)")
        let db = Firestore.firestore()
        db.collection("coursesRequests").document(course.id).delete()
        onUpdate(course)
        
        db.collection("courses").document(course.id).setData(course.toDictionary()) { error in
            if let error = error {
                print("Error adding document)")
            } else {
                print("course added to Courses successfully")
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
                print("Error adding document)")
            } else {
                print("course added to rejected courses list")
            }
        }
    }
    
}
