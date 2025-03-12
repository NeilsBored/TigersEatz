import SwiftUI

// MARK: - CircularProgressView

struct CircularProgressView: View {
    var progress: Double = 0.0
    var travelTime: Double = 0.0
    var segments: [(Double, Color)] = []
    var calorieCount: Int? = nil
    var budgetLeft: Int? = nil
    var customForegroundColor: Color? = nil
    var lineWidth: CGFloat = 10
    var backgroundColor: Color = Color.gray.opacity(0.3)

    var computedSegments: [(start: Double, end: Double, color: Color)] {
        var segmentsData = [(start: Double, end: Double, color: Color)]()
        var currentStart: Double = 0
        for seg in segments {
            segmentsData.append((
                start: currentStart,
                end: currentStart + seg.0,
                color: seg.1
            ))
            currentStart += seg.0
        }
        return segmentsData
    }

    var foregroundColor: Color {
        segments.isEmpty ? (customForegroundColor ?? .green) : .clear
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(backgroundColor, lineWidth: lineWidth)

            if segments.isEmpty {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        foregroundColor,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
            } else {
                ForEach(Array(computedSegments.enumerated()), id: \.offset) { _, seg in
                    Circle()
                        .trim(from: seg.start, to: seg.end)
                        .stroke(
                            seg.color,
                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                }
            }

            if let calorieCount = calorieCount {
                Text("\(calorieCount)")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .contextMenu {
                        VStack(alignment: .leading) {
                            Text("Daily Intake Goal Progress:")
                            Text("Next class in \(Int(travelTime * 100)) mins")
                            Text("🥑 Fat: 20g (30%)")
                            Text("🍗 Protein: 35g (50%)")
                            Text("🍚 Carbs: 50g (60%)")
                        }
                        .font(.caption)
                    }
            }
            if let budgetLeft = budgetLeft {
                Text("$\(budgetLeft)")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .contextMenu {
                        Text("💰 $17.65 remaining today")
                            .font(.caption)
                    }
            }
        }
        .frame(width: 55, height: 55)
    }
}

// MARK: - CapacityIndicator

struct CapacityIndicator: View {
    enum CapacityLevel {
        case empty, notBusy, kindaBusy, busy
    }

    var level: CapacityLevel

    func colorForIcon(index: Int) -> Color {
        switch level {
        case .empty:
            return .black
        case .notBusy:
            return index == 0 ? .green : .black
        case .kindaBusy:
            return index < 2 ? .orange : .black
        case .busy:
            return .red
        }
    }

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { index in
                Image(systemName: "person.fill")
                    .foregroundColor(colorForIcon(index: index))
                    .font(.system(size: 18))
                    .offset(x: -5, y: 4)
            }
        }
    }
}

// MARK: - CardModifier

struct CardModifier: ViewModifier {
    var isSelected: Bool
    var anySelected: Bool
    var selectedBorderColor: Color

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: 400)
            .frame(minHeight: 155, maxHeight: 155)
            .background(
                isSelected ? Color(UIColor.systemGray3) : Color(UIColor.systemGray6)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(
                        isSelected ? selectedBorderColor : .clear,
                        lineWidth: isSelected ? 3 : 0
                    )
            )
            .shadow(radius: 3)
            .animation(.easeInOut(duration: 0.3), value: isSelected)
            .scaleEffect(!anySelected ? 0.95 : (isSelected ? 0.95 : 0.85))
           
    }
}

extension View {
    func cardStyle(
        isSelected: Bool,
        anySelected: Bool,
        selectedBorderColor: Color
    ) -> some View {
        modifier(CardModifier(
            isSelected: isSelected,
            anySelected: anySelected,
            selectedBorderColor: selectedBorderColor
        ))
    }
}

// MARK: - Data Model

struct Restaurant: Identifiable {
    let id: Int
    let imageName: String
    let title: String
    let address: String
    let capacity: CapacityIndicator.CapacityLevel
    let openStatus: String
    let waitTime: Int  // changed from String to Int
    let dietLabel: String
    let costLabel: String
    let borderColor: Color
}

// MARK: - RestaurantCard

struct RestaurantCard: View {
    let restaurant: Restaurant
    @Binding var selectedCardId: Int?
    @Binding var swipeOffsets: [Int: CGFloat]
    let onRemove: () -> Void

    var body: some View {
        ZStack {
            // Background: option buttons
            VStack(spacing: 10) {
                Button("Start Order") {
                    // start order
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 130, height: 43)
                .background(Color.blue)
                .cornerRadius(5)
                .shadow(radius: 1)
                
                NavigationLink(destination: RestaurantProfileView()) {
                    Text("View Info")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 130, height: 35)
                        .background(Color.gray)
                        .cornerRadius(5)
                }
            
                
                Button("Remove") {
                    onRemove()
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(width: 130, height: 37)
                .background(Color.clear)
                .border(Color.gray, width: 3)
                .cornerRadius(5)
            }
            .frame(maxHeight: .infinity)
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .scaleEffect(selectedCardId == nil || selectedCardId == restaurant.id ? 0.95 : 0.85)

            // Foreground: card content
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .center, spacing: 12) {
                    Image(restaurant.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)

                    VStack(alignment: .leading) {
                        HStack {
                            Text(restaurant.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            CapacityIndicator(level: restaurant.capacity)
                        }
                        Text(restaurant.address)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                HStack(alignment: .center, spacing: 40) {
                    VStack(alignment: .leading) {
                        Label(restaurant.openStatus, systemImage: (restaurant.openStatus == "Open" ? "checkmark.circle" : "xmark.circle"))
                        Label {
                            Text("\(restaurant.waitTime) mins")
                        } icon: {
                            Image(systemName: "clock")
                        }
                    }
                    VStack(alignment: .leading) {
                        Label(restaurant.dietLabel, systemImage: "leaf")
                        Label(restaurant.costLabel, systemImage: "dollarsign.circle")
                    }
                    Spacer()
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30))
                        .foregroundColor(selectedCardId == restaurant.id ? .white : .gray)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .cardStyle(
                isSelected: selectedCardId == restaurant.id,
                anySelected: selectedCardId != nil,
                selectedBorderColor: restaurant.borderColor
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            let newOffset = max(value.translation.width, -150)
                            swipeOffsets[restaurant.id] = newOffset
                        }
                    }
                    .onEnded { value in
                        withAnimation(.easeInOut) {
                            if value.translation.width < -80 {
                                swipeOffsets[restaurant.id] = -150
                            } else {
                                swipeOffsets[restaurant.id] = 0
                            }
                        }
                    }
            )
            .offset(x: swipeOffsets[restaurant.id] ?? 0)
            .contextMenu {
                Button("Start Order") {
                    // order
                }
                Button("View Info") {
                    // info
                }
                Button("Remove") {
                    // remove
                }
            }
            .onTapGesture {
                if (swipeOffsets[restaurant.id] ?? 0) != 0 {
                    withAnimation(.easeInOut) {
                        swipeOffsets[restaurant.id] = 0
                    }
                } else {
                    selectedCardId = restaurant.id
                }
            }
        }
    }
}

// MARK: - HomeScreenView

struct HomeScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var classProgress: Double = 0
    @State private var travelTime: Double = 0
    @State private var selectedCardId: Int? = nil
    @State private var nutritionProgress: Double = 0.5
    @State private var budgetProgress: Double = 0.7
    @State private var swipeOffsets: [Int: CGFloat] = [:]
    @State private var searchText: String = ""
    @State private var showingFilterPicker: Bool = false
    @State private var selectedFilter: String = "All"

    @State private var restaurants: [Restaurant] = [
        Restaurant(
            id: 1,
            imageName: "Chicky",
            title: "Chick-fil-a",
            address: "201 Fernow Street",
            capacity: .kindaBusy,
            openStatus: "Open",
            waitTime: 18,  // was "18 mins"
            dietLabel: "Gluten-Free",
            costLabel: "$$",
            borderColor: .red
        ),
        Restaurant(
            id: 2,
            imageName: "Dish",
            title: "The Dish - DH",
            address: "511 Fort Hill Street",
            capacity: .notBusy,
            openStatus: "Open",
            waitTime: 8,   // was "~8 min"
            dietLabel: "Gluten-Free",
            costLabel: "$$",
            borderColor: .orange
        ),
        Restaurant(
            id: 3,
            imageName: "pod",
            title: "P.O.D. at Daniel",
            address: "113 Delta Epsilon Court",
            capacity: .busy,
            openStatus: "Open",
            waitTime: 26,  // was "26 mins"
            dietLabel: "Vegetarian",
            costLabel: "$",
            borderColor: .green
        ),
        Restaurant(
            id: 4,
            imageName: "bagel",
            title: "Einstein Bros.",
            address: "Hendrix Student Center",
            capacity: .empty,
            openStatus: "Closed",
            waitTime: 0,  // was "N/A" (using 0 to indicate not applicable)
            dietLabel: "Vegan Options",
            costLabel: "$$",
            borderColor: .brown
        )
    ]
    
    private var selectedRestaurantBorderColor: Color {
        if let id = selectedCardId,
           let restaurant = restaurants.first(where: { $0.id == id }) {
            return restaurant.borderColor
        }
        return .orange
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {

                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Human Computer Interaction")
                                .font(.headline)
                                .fontWeight(.semibold)
                            HStack {
                                Text("Academic Success Center 118")
                                    .font(.caption)
                                Spacer()
                                Text("Next Class:")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .offset(y: 10)
                                Text("\(Int(travelTime)) mins")
                                    .font(.caption)
                                    .offset(x: -6, y: 10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            Rectangle()
                                .frame(height: 5)
                                .foregroundColor(Color.gray.opacity(0.3))
                                .cornerRadius(3)
                                .contextMenu {
                                    VStack {
                                        Text("🍴 Time To Eat: 15 mins")
                                        Text("⏰ Remaining Time: 8 mins")
                                    }
                                    .font(.caption)
                                }

                            Rectangle()
                                .frame(width: geometry.size.width * travelTime, height: 5)
                                .foregroundColor(.gray)
                                .cornerRadius(3)
                                .contextMenu {
                                    Text("🚗 Travel Time: \(Int(travelTime * 100)) min")
                                        .font(.caption)
                                }

                            Rectangle()
                                .frame(width: geometry.size.width * (classProgress + travelTime), height: 5)
                                .foregroundColor(selectedRestaurantBorderColor)
                                .offset(x: geometry.size.width * travelTime)
                                .cornerRadius(3)
                                .contextMenu {
                                    Text("⏳ Wait For Food: 18 mins")
                                        .font(.caption)
                                }
                        }
                    }
                    .frame(height: 8)
                    .padding(.horizontal)
                    .scaleEffect(x: 1, y: 2.2)
                    .offset(y: 9)
                }
                .onAppear {
                    withAnimation(.linear(duration: 1)) {
                        travelTime = 0.15
                        classProgress = 0.68
                    }
                }

                HStack(alignment: .center, spacing: 55) {
                    VStack {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 37, height: 37)
                        Text("Favorites")
                            .font(.caption)
                    }
                    .offset(x: -15)

                    VStack {
                        Image("me")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                        Text("Profile")
                            .font(.caption)
                    }
                    .offset(x: -14)

                    VStack {
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 35, height: 35)
                        Text("Wallet")
                            .font(.caption)
                    }
                }
                .padding(.bottom, -25)

                ScrollView {
                    
                    VStack {
                        GeometryReader { geo in
                            // Calculate the offset (negative when scrolling up)
                            let offset = geo.frame(in: .named("scroll")).minY
                            // When offset is 0, scale is 1; when offset is -80 or lower, scale is 0
                            let scale = max(0, min(1, 1 + offset / 80))

                            Text("Coding marathon kinda day?\nTime to refuel.")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .dark ? .white : Color(.darkGray))
                                .scaleEffect(scale)
                                .opacity(scale)
                                .offset(x: 25)
                        }
                        .frame(height: 80)

                        HStack {
                            TextField("Search restaurants...", text: $searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300, height: 30)
                                .padding(.leading, 5)
                                .background(
                                    colorScheme == .dark ? Color(.systemGray6) : .white
                                )
                                .cornerRadius(5)
                                .shadow(radius: 2)

                            Button {
                                showingFilterPicker = true
                            } label: {
                                Image(systemName: "line.horizontal.3.decrease.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.horizontal)

                        ForEach(restaurants) { resto in
                            RestaurantCard(
                                restaurant: resto,
                                selectedCardId: $selectedCardId,
                                swipeOffsets: $swipeOffsets,
                                onRemove: {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                                        restaurants.removeAll { $0.id == resto.id }
                                    }
                                }
                            )
                            .transition(AnyTransition.scale(scale: 0.1, anchor: .center).combined(with: .opacity))
                        }
                    }
                    .padding(.top, 16)
                }
                .coordinateSpace(name: "scroll")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CircularProgressView(
                            segments: [(0.35, .orange), (0.25, .purple), (0.4, .brown)],
                            calorieCount: 863
                        )
                        .offset(x: 20)
                    }
                    ToolbarItem(placement: .principal) {
                        HStack(spacing: 8) {
                            Image("Clemson")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(
                                    Color(red: 246/255, green: 103/255, blue: 51/255)
                                )
                            Text("TigerEatz")
                                .font(.headline)
                                .foregroundColor(
                                    Color(red: 82/255, green: 45/255, blue: 128/255)
                                )
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        CircularProgressView(
                            progress: budgetProgress,
                            budgetLeft: 17,
                            customForegroundColor: .green
                        )
                        .offset(x: -20)
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingFilterPicker) {
            VStack {
                Text("Select Filter")
                    .font(.headline)
                    .padding()
                Picker("Search Filter", selection: $selectedFilter) {
                    Text("All").tag("All")
                    Text("Open Now").tag("Open Now")
                    Text("Favorites").tag("Favorites")
                    Text("Nearby").tag("Nearby")
                }
                //.pickerStyle(InlinePickerStyle())
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .padding()

                Button("Done") {
                    showingFilterPicker = false
                }
                .padding()
            }
            .presentationDetents([.fraction(0.38)])
            .presentationDragIndicator(.visible)
        }
    }
}


// MARK: - Preview

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
