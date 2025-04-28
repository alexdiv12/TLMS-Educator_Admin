//
//  ResetPasswordView.swift
//  EduMatrix Admin
//
//  Created by aaa on 05/07/24.
//
import Foundation
import SwiftUI

struct ResetPasswordView: View {
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var navigateToSuccessView: Bool = false
    //@StateObject var userViewModel = UserViewModel()

    var body: some View {
//        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("Star 8") // Replace with your image name from assets
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 16)
                        .foregroundColor(.blue) // Customize the image color if needed
                }
                .padding(.top, 16)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Reset Password")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                        .padding(.leading, 4)
                    
                    Text("New Password")
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 4)

                    SecureField("Enter new password", text: $newPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 4)

                    Text("Confirm New Password")
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 4)

                    SecureField("Confirm new password", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 4)

                    Spacer().frame(height: 30)

                    NavigationLink(destination: ResetSuccessView(), isActive: $navigateToSuccessView) {
                        Button(action: {
                            // Here you can add validation logic before navigating
                            if newPassword == confirmPassword && !newPassword.isEmpty {
                                navigateToSuccessView = true
                            } else {
                                // Handle validation errors (e.g., show an alert)
                            }
                        }) {
                            Text("Reset Password")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .padding(.horizontal, 4)
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 4)
            }
            .padding()
            // .navigationBarHidden(true)
        }
    }
//}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}


