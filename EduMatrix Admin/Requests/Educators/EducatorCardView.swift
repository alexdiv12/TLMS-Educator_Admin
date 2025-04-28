import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct EducatorCardView: View {
    var educator: Educator
    var onUpdate: (Educator) -> Void
    @State private var profileImage: UIImage? = UIImage(named: "reload")
    @State private var showAlertConfirm = false
    @State private var showAlertReject = false
    
    var body: some View {
        NavigationLink(destination: EducatorDetailView(educator: educator)) {
            HStack(alignment: .center, spacing: 16) {
                // Profile Picture
                Image(uiImage: profileImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                    .padding(.vertical, 8)
                
                // Educator Details
                VStack(alignment: .leading, spacing: 5) {
                    Text(educator.fullName)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black) // Set text color to black
                        .lineLimit(1)
                    
                    Text(educator.qualification)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading) // Ensure left alignment
                }
                
                Spacer()
                
                // Approve and Reject Buttons
                VStack(spacing: 8) {
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
                            message: Text("Do you want to accept the educator onboarding request?"),
                            primaryButton: .default(Text("No")) ,
//                            {
//                                print("Accepted")
//                                approveEducator()
//                            },
                            secondaryButton: .cancel(Text("Yes")){
                                print("Accepted")
                                approveEducator()
                            }
                        )
                    }

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
                            message: Text("Do you want to reject the educator onboarding request?"),
                            primaryButton: .default(Text("No")),
                            secondaryButton: .cancel(Text("Yes")){
                                print("Rejected")
                                rejectEducator()
                            }
                        )
                    }
                }
                .onAppear {
                    Services.loadImage(from: URL(string: educator.profileImageURL)!) { image in
                        self.profileImage = image
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 3)
            .padding(.horizontal, 5) // Add padding to match the overall layout
        }
    }
    
    func approveEducator() {
        print("Approved \(educator.fullName)")
        let db = Firestore.firestore()
        db.collection("educatorsRequests").document("\(educator.email)").delete()
        onUpdate(educator)
        
        Auth.auth().createUser(withEmail: educator.email, password: "987654321") { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                // guard let userID = authResult?.user.uid else { return }
                let db = Firestore.firestore()
                db.collection("educators").document(educator.email).setData(educator.toDictionary()) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("User signed up successfully")
                    }
                }
            }
        }
    }
    
    func rejectEducator() {
        print("Rejected \(educator.fullName)")
        let db = Firestore.firestore()
        db.collection("educatorsRequests").document("\(educator.email)").delete()
        onUpdate(educator)

        db.collection("rejectedEducators").document(educator.email).setData(educator.toDictionary()) { error in
            if let error = error {
                print("Error adding document \(error)")
            } else {
                print("Educator added in the Rejected List")
            }
        }
    }
}

struct EducatorCardView_Previews: PreviewProvider {
    static var previews: some View {
        let educator = Educator(
            fullName: "Alice Johnson",
            email: "alice.johnson@example.com",
            mobileNumber: "123-456-7890",
            qualification: "PhD in Mathematics",
            experience: "10 years",
            subjectDomain: "Mathematics",
            language: "English, Spanish",
            aadharImageURL: "jdfhlsiear",
            profileImageURL: "sfksl",
            about: "Passionate about teaching and research in Mathematics."
        )
        EducatorCardView(educator: educator, onUpdate: { _ in })
    }
}
