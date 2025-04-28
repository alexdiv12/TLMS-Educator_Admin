//
//  HelpSupportView.swift
//  loginCheck
//
//  Created by aaa on 12/07/24.
//

import SwiftUI



struct HelpSupportView: View {
    var body: some View {
        ScrollView{
            ZStack(alignment: .top) {
                VStack {
                    // Background color for the top section
                    Color(red: 0.145, green: 0.635, blue: 1.0) // Equivalent to #25A2FF
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 300) // Adjust height as needed
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hello 👋")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    Text("How can we help?")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 20) {
                                NavigationLink(destination: FAQView()) {
                                    HelpSupportRow(title: "FAQs", subtitle: "Frequently asked questions", icon: "message")
                                }

                                Button(action: {
                                    openWhatsApp(phoneNumber: "6396386230", message: "Hello, I need help with...")
                                }) {
                                    HelpSupportRow(title: "Contact us", subtitle: "We usually take 4-5 hours to respond 😊", icon: "phone")
                                }
                            }
                            .padding(.vertical, 20)
                    
                    // Default background color section starts here
                    VStack(alignment: .leading, spacing: 20) {
                        Text("FAQs categories")
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            NavigationLink(destination: FAQView()) {
                                FAQCategoryItem(title: "Getting Started", icon: "person.crop.circle")
                            }
                            NavigationLink(destination: FAQView()) {
                                FAQCategoryItem(title: "Account Management", icon: "person.crop.circle")
                            }
                            NavigationLink(destination: FAQView()) {
                                FAQCategoryItem(title: "Progress Tracking", icon: "gauge")
                            }
                            NavigationLink(destination: FAQView()) {
                                FAQCategoryItem(title: "Quizzes and Assignments", icon: "doc.text.magnifyingglass")
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Help & Support")
        }
            .navigationViewStyle(StackNavigationViewStyle())
        }
}

func openWhatsApp(phoneNumber: String, message: String) {
        let urlString = "https://wa.me/\(phoneNumber)?text=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    struct HelpSupportRow: View {
        let title: String
        let subtitle: String
        let icon: String
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        }
    }
    
    struct FAQCategoryItem: View {
        let title: String
        let icon: String
        
        var body: some View {
            VStack {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .frame(width: 60, height: 60)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
                
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)  // Ensures the item takes up equal space
            }
            .padding()
            .frame(width: 160, height: 160)  // Fixed size for equal sections
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        }
    }
    
    //struct HelpSupportView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        HelpSupportView()
    //    }
    //}
    #Preview{
        HelpSupportView()
            .environment(\.colorScheme, .light)
    }
    
    extension Color {
        static let backgroundColor = Color("BackgroundColor")
    }
