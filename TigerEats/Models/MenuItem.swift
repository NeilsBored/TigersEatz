import Foundation

/// Represents a single item that can appear on a restaurant's menu.
struct MenuItem: Identifiable {
    let id: Int
    let name: String
    let detail: String
    let price: Double
}
