//
//  FAQsView.swift
//  loginCheck
//
//  Created by aaa on 12/07/24.
//

import SwiftUI

struct FAQView: View {
    @State private var expandedSection: Int? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image("FAQimage") // Replace "faq_header" with your image name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 20)

                    Text("☁️ In doubt?")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    Text("We got it covered for you 👍")
                        .font(.headline)
                        .padding(.bottom, 20)

                    FAQSection(title: "Getting Started", isExpanded: expandedSection == 0) {
                        if expandedSection == 0 {
                            GettingStartedFAQContent()
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            expandedSection = expandedSection == 0 ? nil : 0
                        }
                    }

                    FAQSection(title: "Account Management Queries", isExpanded: expandedSection == 1) {
                        if expandedSection == 1 {
                            AccountManagementFAQContent()
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            expandedSection = expandedSection == 1 ? nil : 1
                        }
                    }

                    FAQSection(title: "Progress Tracking Queries", isExpanded: expandedSection == 2) {
                        if expandedSection == 2 {
                            ProgressTrackingFAQContent()
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            expandedSection = expandedSection == 2 ? nil : 2
                        }
                    }

                    FAQSection(title: "Quizzes And Assignment Queries", isExpanded: expandedSection == 3) {
                        if expandedSection == 3 {
                            QuizzesAndAssignmentsFAQContent()
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            expandedSection = expandedSection == 3 ? nil : 3
                        }
                    }

                    Spacer()

                    Text("doubt")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(" solved ?")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    Text("if no,\nFeel free to")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    Text(" contact us !!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.bottom, 20)
                }
                .padding()
            }
            .navigationBarTitle("FAQ", displayMode: .inline)
        }
    }
}

struct FAQSection<Content: View>: View {
    let title: String
    let isExpanded: Bool
    let content: Content

    init(title: String, isExpanded: Bool, @ViewBuilder content: () -> Content) {
        self.title = title
        self.isExpanded = isExpanded
        self.content = content()
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .foregroundColor(.blue)
                Text(title)
                    .font(.headline)
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))

            if isExpanded {
                content
                    .padding()
            }
        }
    }
}

struct FAQContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Here you can provide the answer to the question.")
            Text("You can add more text here to elaborate.")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
    }
}

struct GettingStartedFAQContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Question 1: How to create an account?")
                .font(.headline)
            Text("Answer: To create an account, click on the Sign Up button on the home screen and follow the instructions.")
            
            Divider()
            
            Text("Question 2: How to reset your password?")
                .font(.headline)
            Text("Answer: To reset your password, click on Forgot Password link on the login screen and follow the instructions.")
            
            Divider()
            
            Text("Question 3: How to update your profile information?")
                .font(.headline)
            Text("Answer: Go to the Profile section, click on Edit Profile and update your information.")
            
            Divider()
            
            Text("Question 4: How to contact support?")
                .font(.headline)
            Text("Answer: Go to the Help & Support section in the app and follow the instructions to contact our support team.")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
    }
}

struct AccountManagementFAQContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Question 1: How to change your email address?")
                .font(.headline)
            Text("Answer: Go to Account Settings, click on Change Email and follow the instructions.")
            
            // Add more questions and answers for this section
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
    }
}

struct ProgressTrackingFAQContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Question 1: How to track your progress?")
                .font(.headline)
            Text("Answer: Go to the Progress section in the app to see detailed statistics of your learning.")
            
            // Add more questions and answers for this section
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
    }
}

struct QuizzesAndAssignmentsFAQContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Question 1: How to attempt quizzes?")
                .font(.headline)
            Text("Answer: Go to the Quizzes section in the app and select the quiz you want to attempt.")
            
            // Add more questions and answers for this section
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
