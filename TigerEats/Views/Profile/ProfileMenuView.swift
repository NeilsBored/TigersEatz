import SwiftUI

struct ProfileMenuView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink("Edit Profile", destination: EditProfileView())
            }
            .navigationTitle("Profile")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct ProfileMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuView()
    }
}
