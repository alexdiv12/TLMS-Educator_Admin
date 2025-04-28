//
//  ProfileView.swift
//  EduMatrix Admin
//
//  Created by aaa on 17/07/24.
//

import SwiftUI
import PhotosUI

// Model to hold user profile data
class UserProfile: ObservableObject {
    @Published var name: String = "Sunny Siddhu"
    @Published var email: String = "sunnysiddhu886@gmail.com"
    @Published var username: String = "sunnysiddhu"
    @Published var pronouns: String = "He/His"
    @Published var password: String = "******"
    @Published var phoneNumber: String = "6396386230"
    @Published var gender: String = "Male"
    @Published var profileImage: UIImage? = UIImage(named: "educator1")
}

struct ProfileView: View {
    @StateObject private var userProfile = UserProfile()
    @State private var isImagePickerPresented = false
    @State private var showAlert = false
    @State private var navigateToLogin = false
    //@State private var showAlert = false
    @State private var showLoginView = false
    @State private var selectedImage: UIImage? = UIImage(named: "placeholder") // Placeholder image
    @State private var isActionSheetPresented = false
    @State private var isCamera = false
    
    var body: some View {
        //        NavigationView {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Image and Name
                VStack(spacing: 8) {
                    ZStack(alignment: .bottomTrailing) {
                                    Image(uiImage: userProfile.profileImage!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                        .shadow(radius: 10)
                                        .onTapGesture {
                                            isActionSheetPresented = true
                                        }
                                    
                                    Button(action: {
                                        isActionSheetPresented = true
                                    }) {
                                        Image(systemName: "pencil.circle.fill")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.gray)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                    }
                                    .offset(x: -10, y: -10)
                                }
                                .actionSheet(isPresented: $isActionSheetPresented) {
                                    ActionSheet(
                                        title: Text("Change Profile Image"),
                                        message: Text("Choose an option to update your profile image"),
                                        buttons: [
                                            .default(Text("Camera")) {
                                                isCamera = true
                                                isImagePickerPresented = true
                                            },
                                            .default(Text("Gallery")) {
                                                isCamera = false
                                                isImagePickerPresented = true
                                            },
                                            .cancel()
                                        ]
                                    )
                                }
                                .sheet(isPresented: $isImagePickerPresented) {
                                    ImagePicker(profileImage: $userProfile.profileImage, isCamera: isCamera)
                                }
                            
                    
                    Text(userProfile.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(userProfile.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 30)
                
                // Sections
                VStack(spacing: 16) {
                    ProfileSection(title: "Personal Information", iconName: "info.circle", destination: AnyView(PersonalInformationView(userProfile: userProfile)))
                    //                        NavigationLink(destination: ForgotPasswordView()) {
                    ProfileSection(title: "Forgot Password", iconName: "lock.circle", destination: AnyView(ForgotPasswordView()))
                    //                        }
                    ProfileSection(title: "Help & Support", iconName: "questionmark.circle", destination: AnyView(HelpSupportView()))
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    HStack {
                        Image(systemName: "power.circle")
                            .font(.title2)
                            .foregroundColor(.blue)
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showAlert = true
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you sure you want to log out?"),
                            primaryButton: .destructive(Text("Log Out")) {
                                showLoginView = true
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    .fullScreenCover(isPresented: $showLoginView) {
                        LoginView()
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(profileImage: $userProfile.profileImage, isCamera: isCamera)
        }
    }
    
}

struct ProfileSection: View {
    var title: String
    var iconName: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                    .frame(width: 32, height: 32)
                
                Text(title)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

struct PersonalInformationView: View {
    @ObservedObject var userProfile: UserProfile
    @State private var isImagePickerPresented = false
    @State private var nameError: String?
    @State private var isCamera = false
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var isSaveButtonDisabled: Bool {
        userProfile.name.isEmpty || userProfile.username.isEmpty || userProfile.pronouns.isEmpty || userProfile.password.isEmpty || userProfile.phoneNumber.isEmpty || userProfile.gender.isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                VStack(spacing: 8) {
                    ZStack(alignment: .bottomTrailing) {
                        Image(uiImage: userProfile.profileImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                        
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray)
                                .background(Color.white)
                                .clipShape(Circle())
                                .accessibility(label: Text("Edit Profile Image"))
                                .accessibility(hint: Text("Tap to change the profile image"))
                        }
                        .offset(x: -10, y: -10)
                    }
                    
                    TextField("Name", text: $userProfile.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .accessibility(label: Text("Name"))
                        .accessibility(hint: Text("Enter your name"))
                        .onChange(of: userProfile.name) { newValue in
                            validateName()
                        }
                        .onSubmit {
                            validateName()
                        }

                    if let nameError = nameError {
                        Text(nameError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .accessibility(label: Text("Name Error"))
                            .accessibility(hint: Text(nameError))
                    }
                    
                    Text("Admin")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, -25)
                }
                .padding(.top, -70)
                
                FormField(title: "User name", text: $userProfile.username)
                    .accessibility(label: Text("Username"))
                    .accessibility(hint: Text("Enter your username"))
                FormField(title: "Pronouns", text: $userProfile.pronouns)
                    .accessibility(label: Text("Pronouns"))
                    .accessibility(hint: Text("Enter your pronouns"))
                FormField(title: "Password", text: $userProfile.password, isSecure: true)
                    .accessibility(label: Text("Password"))
                    .accessibility(hint: Text("Enter your password"))
                FormField(title: "Phone number", text: $userProfile.phoneNumber)
                    .accessibility(label: Text("Phone Number"))
                    .accessibility(hint: Text("Enter your phone number"))
                FormField(title: "Gender", text: $userProfile.gender)
                    .accessibility(label: Text("Gender"))
                    .accessibility(hint: Text("Enter your gender"))
                
                Button(action: {
                    if isSaveButtonDisabled {
                        showAlert = true
                    } else {
                        // Save action
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isSaveButtonDisabled ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .accessibility(label: Text("Save Button"))
                        .accessibility(hint: Text("Tap to save your changes"))
                }
                .disabled(isSaveButtonDisabled)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Incomplete Information"),
                        message: Text("Please fill all the fields before saving."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .padding(.top, 20)
                .keyboardShortcut(.defaultAction)
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func validateName() {
        if userProfile.name.isEmpty {
            nameError = "Name cannot be empty"
        } else if Double(userProfile.name) != nil {
            nameError = "Name cannot be a number"
        } else if !userProfile.name.trimmingCharacters(in: .whitespaces).isEmpty {
            nameError = nil
        } else {
            nameError = "Name must contain some characters"
        }
    }
}

struct FormField: View {
    var title: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if isSecure {
                SecureField("", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            } else {
                TextField("", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
        }
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var profileImage: UIImage?
    var isCamera: Bool
    
    @Environment(\.presentationMode) private var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.profileImage = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = isCamera ? .camera : .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
