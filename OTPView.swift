//
//  OTPView.swift
//  EduMatrix Admin
//
//  Created by aaa on 05/07/24.
//

import Foundation
import SwiftUI

struct OTPView: View {
    @State private var otpFields: [String] = Array(repeating: "", count: 4) // State variable to hold user-entered OTP digits
    @State private var showAlert: Bool = false // State variable to control alert presentation
    @State private var isOTPVerified: Bool = false // State variable to track OTP verification status
    @State private var navigateToResetPasswordView: Bool = false // State variable to control navigation
    @State private var showResendAlert: Bool = false // State variable to control resend alert presentation
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
                Spacer().frame(height: UIScreen.main.bounds.height * 0.19)

                VStack(alignment: .leading) {
                    Text("Please check your email")
                        .font(.largeTitle)
                        .fontWeight(.bold) // Making the first heading text bold
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 2)
                        .padding(.leading, 4)
                    
                    Spacer().frame(height: 15)
                    
                    Text("We’ve sent a code to sunnysiddhu886@gmail.com")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 4)
                }
                .padding(.horizontal, 4)

                Spacer().frame(height: 30)

                HStack {
                    ForEach(0..<4, id: \.self) { index in
                        TextField("", text: $otpFields[index])
                            .keyboardType(.numberPad)
                            .font(.title)
                            .frame(width: 70, height: 70)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .multilineTextAlignment(.center)
                            .padding(4)
                            .onChange(of: otpFields[index]) { newValue in
                                if newValue.count > 1 {
                                    otpFields[index] = String(newValue.prefix(1))
                                }
                                if newValue.count == 1 {
                                    if index < 3 {
                                        // Focus next field
                                        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                                    } else {
                                        // Dismiss keyboard
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }
                                }
                            }
                    }
                }
                .padding(.horizontal, 4)

                Spacer().frame(height: 30)

                Button(action: {
                    // Implement verification logic here
                    // For example:
                    let enteredOTP = otpFields.joined()
                    if enteredOTP == "1234" { // Replace "1234" with your actual OTP verification logic
                        isOTPVerified = true // Set OTP verification status
                        showAlert = true
                    } else {
                        isOTPVerified = false // Set OTP verification status
                        showAlert = true
                    }
                }) {
                    Text("Verify")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal, 4)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(isOTPVerified ? "OTP Verified" : "Incorrect OTP"),
                        message: Text(isOTPVerified ? "Your OTP is correct." : "Please check your OTP and try again."),
                        dismissButton: .default(Text("OK")) {
                            if isOTPVerified {
                                navigateToResetPasswordView = true
                            }
                        }
                    )
                }

                NavigationLink(destination: ResetPasswordView(), isActive: $navigateToResetPasswordView) {
                    EmptyView()
                }

                Spacer().frame(height: 30)
                
                Spacer() // Spacer before the "Send code again" text

                Button(action: {
                    // Implement logic to resend the code
                    // For example, resend OTP
                    showResendAlert = true
                }) {
                    Text("Send code again")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.leading, 0)
                }
                .alert(isPresented: $showResendAlert) {
                    Alert(
                        title: Text("OTP Sent"),
                        message: Text("OTP has been sent again."),
                        dismissButton: .default(Text("OK"))
                    )
                }

                Spacer() // Spacer after the "Send code again" text
            }
            .padding()
            //.navigationBarHidden(true)
        }
    }
//}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}

