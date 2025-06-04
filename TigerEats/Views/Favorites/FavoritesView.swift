import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationView {
            Text("Your favorite spots will appear here.")
                .navigationTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
