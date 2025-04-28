import SwiftUI

struct EducatorsListView: View {
    @State private var searchText = ""
    @Binding  var educators: [Educator]
    
    var filteredEducators: [Educator] {
        if searchText.isEmpty {
            return educators
        } else {
            return educators.filter { $0.fullName.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Search Bar
            HStack {
                TextField("Search", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .padding(.top)
            
            
            ScrollView {
                LazyVStack {
                    ForEach(filteredEducators) { educator in
                        NavigationLink(destination: EducatorDetailView(educator: educator)) {
                            EducatorCardView(educator: educator, onUpdate: { updatedEducator in
                                if let index = educators.firstIndex(where: { $0.id == updatedEducator.id }) {
                                    educators.remove(at: index)
                                }
                            })
                        }
                        .listRowBackground(Color.clear) // To make the row background clear
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            
            .padding() // To remove default separators and padding
            Spacer()
        }
        .navigationTitle("Top Educators")
    }
}

struct EducatorRow: View {
    var educator: Educator
    
    var body: some View {
        HStack {
            // Educator Image
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
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.trailing, 10)
            }
            
            // Educator Info
            VStack(alignment: .leading) {
                Text(educator.fullName)
                    .font(.headline)
                Text(educator.subjectDomain)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color.white) // Background color for the card
        .cornerRadius(10) // Rounded corners
        .shadow(radius: 2)// Shadow for the card effect
    }
}

//struct EducatorsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EducatorsListView(educators: sampleEducators)
//    }
//}
