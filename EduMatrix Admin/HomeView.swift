//
//  HomeView.swift
//  EduMatrix Admin
//
//  Created by Sunny Siddhu on 04/07/24.
//

import SwiftUI

struct HomeView: View {
    //    @State private var courses: [Course] = sampleCourses
    //    @State private var educatorsList : [Educator] = sampleEducators
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HomeHeaderView()
                    StatsView()
                    PerformanceChartView()
                    EducatorsView()
//                    CategoriesView()
                    PopularCoursesView()
                }
                .padding()
            }
        }
        //.background(Color(.systemBackground))
        .navigationBarHidden(true)
    }
}

struct HomeHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Hello")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                   // .accessibility(label: Text("Greeting"))
                   // .accessibility(hint: Text("Welcome message"))
                Spacer()
                
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.circle")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
                //.accessibility(label: Text("Profile"))
               // .accessibility(hint: Text("Navigate to profile page"))
            }
            Text("Manage and oversee your platform")
                .font(.subheadline)
                .foregroundColor(Color(.label))
                .fontWeight(.semibold)
               // .accessibility(label: Text("Subtitle"))
                //.accessibility(hint: Text("Description of the app functionality"))
            SearchBarView()
        }
        .padding()
    }
}


struct SearchBarView: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(10)
                .padding(.leading, 25) // Adjust for icon spacing
                .background(Color(.systemGray6)) // Use system color for native look
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        Spacer()
                        if !searchText.isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
        }
        .padding(.horizontal, 10) // Padding around the search bar for better appearance
    }
}






struct StatsView: View {
    var body: some View {
        VStack{
            HStack(spacing: 10) {
                StatItemView(title: "1000", subtitle: "Total Enrollments", icon: "graduationcap.fill")
                StatItemView(title: "11", subtitle: "Total Courses", icon: "book.fill")
                
            }
            
            HStack(spacing: 10) {
                
                StatItemView(title: "20", subtitle: "Total Educators", icon: "person.2.fill")
                StatItemView(title: "20,000", subtitle: "Total Earning", icon: "dollarsign.circle.fill")
            }
        }
    }
}

struct StatItemView: View {
    var title: String
    var subtitle: String
    var icon: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    //.accessibility(label: Text(title))
                   // .accessibility(hint: Text(subtitle))
                Spacer()
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .accessibility(hidden: true)
            }
            HStack{
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(Color(.label))
            }
            Image("wave") // Replace with wave image asset
                .resizable()
            //.aspectRatio(contentMode: .fill)
                .frame(height: 20)
            // .clipped()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .lightGray, radius: 5, x: 0, y: 2)
    }
}

struct PerformanceChartView: View {
    @State private var selectedSegment = 0
    let segments = ["Overall", "Engagement", "Revenue"]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Platform Performance")
                    .font(.headline)
                    .fontWeight(.bold)
                    //.accessibility(label: Text("Platform Performance"))
                   // .accessibility(hint: Text("Displays performance metrics"))
                Spacer()
                Text("This Week")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                   // .accessibility(label: Text("This Week"))
                  //  .accessibility(hint: Text("Performance for the current week"))
                
            }
            .padding(.bottom, 10)
            
            Picker("", selection: $selectedSegment) {
                ForEach(0..<segments.count, id: \.self) {
                    Text(self.segments[$0])
                       // .accessibility(label: Text(self.segments[$0]))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 10)
            
            LineChartView(selectedSegment: $selectedSegment)
                .frame(height: 150)
            
            HStack {
                Circle().fill(Color.blue).frame(width: 10, height: 10)
                Text("Overall")
                    .font(.subheadline)
                   // .accessibility(label: Text("Overall"))
                Spacer()
                Circle().fill(Color.blue.opacity(0.7)).frame(width: 10, height: 10)
                Text("Engagement")
                    .font(.subheadline)
                  //  .accessibility(label: Text("Engagement"))
                Spacer()
                Circle().fill(Color.blue.opacity(0.4)).frame(width: 10, height: 10)
                Text("Revenue")
                    .font(.subheadline)
                   // .accessibility(label: Text("Revenue"))
            }
            .padding(.top, 10)
        }
        .padding()
       // .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: .lightGray, radius: 5, x: 0, y: 2)
    }
}

struct trendingCourseCardView: View {
    let course: Course1

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                // Image section
                if let url = URL(string: course.imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    } placeholder: {
                        Color.gray
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                } else {
                    Color.gray
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                
                // Blur section with description
                VStack(alignment: .leading, spacing: 5) {
                    HStack{
                        Text(course.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                        Text("₹ \(course.price)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    HStack {
                        Text("By \(course.educatorName)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Spacer()
                        HStack {
                            ForEach(0..<5) { star in
                                Image(systemName: star < Int(course.averageRating) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.headline)
                                    .padding(.horizontal,-5)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .background(BlurView(style: .systemMaterialDark).opacity(0.80))
                .frame(height: geometry.size.height / 3) // 1/3rd height of the card
            }
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.vertical, 5)
        }
        .aspectRatio(16/9, contentMode: .fit) // Adjust aspect ratio as needed
        .frame(width: UIScreen.main.bounds.width - 40)
        .shadow(color: .lightGray, radius: 5, x: 0, y: 2)
    }
    
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
struct LineChartView: View {
    @Binding var selectedSegment: Int
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                let data: [CGFloat] = self.dataForSegment(self.selectedSegment)
                guard data.count > 1 else { return }
                
                let stepX = width / CGFloat(data.count - 1)
                let maxY = data.max() ?? 1
                
                path.move(to: CGPoint(x: 0, y: height - (data[0] / maxY * height)))
                
                for i in 1..<data.count {
                    let x = CGFloat(i) * stepX
                    let y = height - (data[i] / maxY * height)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(Color.blue, lineWidth: 2)
            //.accessibility(label: Text("Line Chart"))
           // .accessibility(value: Text("\(self.dataForSegment(self.selectedSegment).map { "\($0)" }.joined(separator: ", "))"))
            
        }
    }
    
    func dataForSegment(_ segment: Int) -> [CGFloat] {
        switch segment {
        case 0: return [0.2, 0.4, 0.6, 0.8, 0.6, 0.4, 0.2]
        case 1: return [0.1, 0.5, 0.3, 0.7, 0.5, 0.3, 0.1]
        case 2: return [0.3, 0.6, 0.4, 0.9, 0.7, 0.5, 0.3]
        default: return []
        }
    }
}


struct EducatorsView: View {
    @State private var educatorsList: [Educator] = sampleEducators
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Educators")
                    .font(.title2)
                    .fontWeight(.bold)
                  //  .accessibility(label: Text("Educators"))
                  //  .accessibility(hint: Text("List of educators"))
                Spacer()
                NavigationLink(destination: EducatorsListView(educators: $educatorsList)) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        //.accessibility(label: Text("See All"))
                       // .accessibility(hint: Text("Navigate to all educators"))
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(educatorsList, id: \.id) { educator in
                        EducatorItemView(educator: educator)
                    }
                }
            }
            .onAppear{
                Services.fetchListOfEducators(){ educators in
                    educatorsList = educators
                }
            }
        }
        .padding()
       // .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: .lightGray, radius: 5, x: 0, y: 2)
    }
}

struct EducatorItemView: View {
    var educator: Educator
    
    var body: some View {
        VStack {
            NavigationLink(destination: EducatorDetailsView(educator: educator)) {
                if let url = URL(string: educator.profileImageURL) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    } placeholder: {
                        Color.gray
                            .frame(width: 60, height: 60)
                            .clipped()
                    }
                }
                //            Text(educator.fullName)
                //                .font(.caption)
                //                .foregroundColor(Color(.label)) // Adapts to dark/light mode
                //                .accessibility(label: Text(educator.fullName))
                //                .accessibility(hint: Text("Name of educator"))
            }
        }
    }
}




//struct CategoryItemView: View {
//    var category: Category
//    
//    var body: some View {
//        VStack {
//            // NavigationLink(destination: CourseDetailView(course: cou, onUpdate: <#(Course1) -> Void#>)) {
//            Image(category.imageName)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 130, height: 170)
//                .cornerRadius(10)
//            Text(category.name)
//                .font(.caption)
//                .foregroundColor(Color(.label)) // Adapts to dark/light mode
//                .accessibility(label: Text(category.name))
//                .accessibility(hint: Text("Name of category"))
//        }
//    }
//}
//
//struct Category: Identifiable {
//    let id = UUID()
//    let name: String
//    let imageName: String
//}

//let categories = [
//    Category(name: "Coding", imageName: "categories"),
//    Category(name: "Graphic Designing", imageName: "categories"),
//    Category(name: "Competitive Exams", imageName: "categories"),
//    Category(name: "Marketing", imageName: "categories")
//]

struct PopularCoursesView: View {
    @State private var courses: [Course1] = sampleCourses
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Popular Courses")
                    .font(.title2)
                    .fontWeight(.bold)
                   // .accessibility(label: Text("Popular Courses"))
                   // .accessibility(hint: Text("List of popular courses"))
                Spacer()
                NavigationLink(destination: AllCoursesGridView(courses: courses)) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        //.accessibility(label: Text("See All"))
                       // .accessibility(hint: Text("Navigate to all popular courses"))
                    
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10 ) {
                    ForEach(courses, id: \.id) { course in
                        trendingCourseCardView(course: course)
                    }
                }
            }
            .onAppear{                Services.fetchListOfCourses(){ courses in
                    self.courses = courses
                }
            }

        }
        .padding()
       // .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: .lightGray, radius: 5, x: 0, y: 2)
    }
}

struct CourseItemView: View {
    var course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomLeading) {
                NavigationLink(destination: CourseDetailsView(course: course)){
                    Image(course.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 240, height: 150)
                        .cornerRadius(10)
//                        .accessibility(label: Text("Course Image"))
//                        .accessibility(hint: Text("Image of the course"))
                }
                Text(course.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding([.leading, .bottom], 8)
                    .background(Color.black.opacity(0.3))
                    .foregroundColor(.white)
//                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
//                    .accessibility(label: Text(course.title))
//                    .accessibility(hint: Text("Title of the course"))
            }
            
            HStack {
                Text(course.duration)
                    .font(.caption)
//                    .accessibility(label: Text("Duration"))
//                    .accessibility(hint: Text(course.duration))
                Spacer()
                Text("Rs.\(course.price)")
                    .font(.caption)
                    .fontWeight(.bold)
//                    .accessibility(label: Text("Price"))
//                    .accessibility(hint: Text("Rs. \(course.price)"))
            }
            HStack {
                Text("\(course.lessons) Lessons")
                    .font(.caption)
//                    .accessibility(label: Text("Lessons"))
//                    .accessibility(hint: Text("\(course.lessons) Lessons"))
                Spacer()
                Text("★ \(course.averageRating, specifier: "%.1f")")
                    .font(.caption)
                    .foregroundColor(.yellow)
//                    .accessibility(label: Text("Rating"))
//                    .accessibility(hint: Text("Rating \(course.averageRating, specifier: "%.1f") stars"))
            }
            
        }
       // .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}

struct CourseDetailsView: View {
    var course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            AsyncImage(url: URL(string: course.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
//                    .accessibility(label: Text("Course Image"))
//                    .accessibility(hint: Text("Image of the course"))
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
//                    .accessibility(label: Text("Placeholder Image"))
//                    .accessibility(hint: Text("Placeholder image for course"))
            }
            .frame(height: 200)
            .clipped()
            
            Text(course.name)
                .font(.title)
                .fontWeight(.bold)
//                .accessibility(label: Text(course.name))
//                .accessibility(hint: Text("Name of the course"))
            
            Text(course.description)
                .font(.body)
//                .accessibility(label: Text("Description"))
//                .accessibility(hint: Text(course.description))
            
            
            HStack {
                Text("Duration: \(course.duration)")
//                    .accessibility(label: Text("Duration"))
//                    .accessibility(hint: Text(course.duration))
                Spacer()
                Text("Language: \(course.language)")
//                    .accessibility(label: Text("Language"))
//                    .accessibility(hint: Text(course.language))
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(course.name)
       // .background(Color(.systemBackground))
    }
}



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Color {
    static let CustomWhite = Color("customWhite")
    static let primaryBlue = Color("PrimaryBlue")
    static let LightGray = Color("lightGray")
}

#Preview{
    HomeView()
}
