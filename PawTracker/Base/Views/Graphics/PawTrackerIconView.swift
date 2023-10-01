//
//  PawTrackerIconView.swift
//  PawTracker
//
//  Created by Simon Topliss on 25/02/2023.
//

import SwiftUI

struct PawTrackerIconView: View {

    // MARK: - BODY
    var body: some View {
        Image("PawTrackerIcon")
            .resizable()
            .scaledToFit()
            .frame(width: 55)
            .clipShape(Circle())
            .shadow(
                color: Constants.Shadows.shadowColor,
                radius: 4
            )
            .shadow(
                color: Constants.Shadows.shadowColor,
                radius: 12
            )
            .accessibilityIdentifier("PawTrackerIconView")
    }
}

// MARK: - PREVIEW
struct PawTrackerIconView_Previews: PreviewProvider {
    static var previews: some View {
        PawTrackerIconView()
            .previewLayout(.sizeThatFits)
    }
}
