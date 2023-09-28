//
//  HomeHeaderView.swift
//  PawTracker
//
//  Created by Simon Topliss on 19/03/2023.
//

import SwiftUI

struct HomeHeaderView: View {

    // MARK: - BODY
    var body: some View {
        VStack {
            Text(Constants.General.appName)
                .font(.system(size: 48))
                .fontDesign(.rounded)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Constants.AppColors.brandPrimary)
                .shadow(
                    color: Constants.Shadows.shadowColor,
                    radius: 8
                )
                .padding(.top)
                .padding(.bottom, 4)
            .accessibilityIdentifier("PawTrackerHeader")
        }
    }
}

// MARK: - PREVIEW
struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
