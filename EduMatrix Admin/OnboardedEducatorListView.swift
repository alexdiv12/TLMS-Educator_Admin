//
//  OnboardedEducatorListView.swift
//  EduMatrix Admin
//
//  Created by Ankit Rajput on 15/07/24.
//

import SwiftUI

struct OnboardedEducatorListView: View {
    @State private var searchText = ""
    var educators: [Educator]

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

            List(filteredEducators) { educator in
                NavigationLink(destination: EducatorDetailView(educator: educator)) {
                    EduRows(educator: educator)
                }
                .listRowBackground(Color.clear) // To make the row background clear
            }
            .listStyle(PlainListStyle()) // To remove default separators and padding
        }
        .navigationTitle("Educators")
    }
}

struct EduRows: View {
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
                .frame(width: 50, height: 50)
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

//            // Navigation Indicator
//            Image(systemName: "chevron.right")
//                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white) // Background color for the card
        .cornerRadius(10) // Rounded corners
        .shadow(radius: 2) // Shadow for the card effect
    }
}

struct OnboardedEducatorListView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardedEducatorListView(educators: sampleEducators)
    }
}

struct OnboardedEducatorDetailView: View {
    var educator: Educator

    var body: some View {
        VStack {
            // Example details for educator
            Text(educator.fullName)
                .font(.largeTitle)
                .padding()
            Text(educator.subjectDomain)
                .font(.title2)
                .padding()
        }
        .navigationTitle(educator.fullName)
    }
}

