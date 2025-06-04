import SwiftUI

struct Restaurant: Identifiable {
    enum CapacityLevel {
        case empty
        case kindaBusy
        case busy
    }

    let id: Int
    let imageName: String
    let title: String
    let address: String
    let capacity: CapacityLevel
    let openStatus: String
    let waitTime: Int
    let dietLabel: String
    let costLabel: String
    let borderColor: Color
}
