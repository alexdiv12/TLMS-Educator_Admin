//
//  ForgotPasswordView.swift
//  EduMatrix Admin
//
//  Created by aaa on 05/07/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var showConfirmation: Bool = false
    @State private var showError: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        //NavigationView {
            VStack {
                Image("forgotPassword") // Use a system image or replace with your own image name
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 220) // Adjust the size as needed
                    .padding(.top, 30) //


                VStack(spacing: 8) {
                    Text("Forgot password?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading,0)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,10)

                    Text("Don’t worry! It happens. Please enter the email associated with your account.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                        .padding(.bottom,10)
                }
                .padding(.bottom, 40)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email address")
                        .font(.headline)

                    TextField("Enter your email address", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .overlay(
                            HStack {
                                Spacer()
                                if email.hasSuffix("@gmail.com") {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                            }
                        )

                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                

                Button(action: {
                    if email.isEmpty {
                        showError = true
                    }
                    else if
                        email.hasSuffix("@gmail.com") {
                        sendResetPasswordLink()
                        showConfirmation = true
                    }
                    
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                Spacer(minLength: 100)
                HStack {
                    Text("Remember password?")
                        .font(.body)

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Log in")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                }
            //}
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please enter your email address."),
                    dismissButton: .default(Text("OK")) {
                        showError = false // Reset the error state
                    }
                )
            }
        }
        .alert(isPresented: $showConfirmation) {
            Alert(
                title: Text("Password Reset"),
                message: Text("A password Reset link has been sent to your email."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                    showConfirmation = false // Reset the confirmation state
                }
            )
        }
        .navigationBarHidden(true)
    }
    func sendResetPasswordLink(){
        Auth.auth().sendPasswordReset(withEmail: email) {(error) in
            if let error = error{
                print("Password Reset Error")
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
