import SwiftUI
import Firebase
import FirebaseFirestore

struct Services{
    
    static func loadImage(from url: URL , completion : @escaping (UIImage) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image from \(url): \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                completion(UIImage(data: data)!)
            }
        }.resume()
    }

    static func fetchListOfCourses(completion: @escaping ([Course1]) -> Void) {
        var courses : [Course1] = []
        let db = Firestore.firestore()
        db.collection("courses").getDocuments { snapshot, error in
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
                        return Video(id: UUID(uuidString: videoData["id"] as! String)!, title: videoData["title"] as? String ?? "", videoURL: URL(string: videoData["videoURL"] as? String ?? "")!)
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
            completion(courses)
        }
    }
    
    static func fetchListOfEducators(completion: @escaping ([Educator]) -> Void) {
        var educators : [Educator] = []
        let db = Firestore.firestore()
        
        db.collection("educators").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                educators = snapshot?.documents.compactMap { document in
                    let data = document.data()
                    print(data)
                    return Educator(
                        id: document.documentID,
                        fullName: data["fullName"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        mobileNumber: data["mobileNumber"] as? String ?? "",
                        qualification: data["qualification"] as? String ?? "",
                        experience: data["experience"] as? String ?? "",
                        subjectDomain: data["subjectDomain"] as? String ?? "",
                        language: data["language"] as? String ?? "",
                        aadharImageURL: data["aadharImageURL"] as?  String ?? "",
                        profileImageURL: data["profileImageURL"] as? String ?? "",
                        about: data["about"] as? String ?? ""
                    )
                } ?? []
            }
            completion(educators)
        }
    }
}
