import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = "Sean Johnson"
    @State private var email: String = "seanj@clemson.edu"
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var imageData: Data?

    var body: some View {
        Form {
            Section(header: Text("Profile Picture")) {
                VStack {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Image("me")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }

                    PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                        Text("Choose New Picture")
                            .foregroundColor(.blue)
                            .font(.headline)
                    }
                    .onChange(of: selectedPhoto) {
                        Task {
                            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                self.profileImage = Image(uiImage: uiImage)
                                self.imageData = data
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }

            Section(header: Text("Name")) {
                TextField("Full Name", text: $name)
            }

            Section(header: Text("Email")) {
                TextField("Email Address", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }

            Section {
                Button("Save Changes") {
                    // Save logic here
                    print("Saved: \(name), \(email)")
                }
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfileView()
        }
    }
}
