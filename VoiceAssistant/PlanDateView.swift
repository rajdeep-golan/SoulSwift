//
//  PlanDateView.swift
//  Soul
//
//  Created by Prakashdeep Golan on 3/11/25.
//

import SwiftUI

struct PlanDateView: View {
    @State private var selectedDate = 4 // Example: Selected date is 4
    @State private var searchQuery = ""

    let availableDates = Array(1...31) // Example: Days of the month
    let availableLocations = [
        "Italian Restaurant\n123 Main St, City",
        "Café Central\n456 Park Ave, City"
    ]

    var body: some View {
        VStack {
            // Header
            HStack {
                Spacer()
                Text("SoulMate")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.top)

            // Card View
            VStack(spacing: 20) {
                // Select Date & Time
                VStack(alignment: .leading) {
                    Text("Select Date & Time")
                        .font(.headline)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                        ForEach(availableDates, id: \.self) { day in
                            Text("\(day)")
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(selectedDate == day ? Color.purple : Color(.systemGray6))
                                .foregroundColor(selectedDate == day ? .white : .primary)
                                .cornerRadius(8)
                                .onTapGesture {
                                    selectedDate = day
                                }
                        }
                    }
                }

                // Choose Location
                VStack(alignment: .leading) {
                    Text("Choose Location")
                        .font(.headline)
                    HStack {
                        TextField("Search for a place...", text: $searchQuery)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }

                    ForEach(availableLocations, id: \.self) { location in
                        LocationRow(location: location)
                    }
                }

                // Plan Date Button
                GradientButtonA(text: "Plan Date", action: {
                    // Implement plan date action
                })
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Shadow
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1) // Elevation effect
            )
            .padding()

            Spacer()
        }
        .padding(.top, 50) // Adjust for status bar
    }
}

// Location Row View
struct LocationRow: View {
    let location: String

    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse") // Placeholder for location icon
                .foregroundColor(.purple)
                .frame(width: 30, height: 30)

            Text(location)
                .font(.subheadline)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

//// Gradient Button View
//struct GradientButton: View {
//    let text: String
//    let action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            Text(text)
//                .fontWeight(.semibold)
//                .foregroundColor(.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
//                .cornerRadius(10)
//        }
//    }
//}

struct PlanDateView_Previews: PreviewProvider {
    static var previews: some View {
        PlanDateView()
    }
}
