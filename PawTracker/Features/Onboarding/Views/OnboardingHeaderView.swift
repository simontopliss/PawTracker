//
//  OnboardingHeaderView.swift
//  PawTracker
//
//  Created by Simon Topliss on 26/03/2023.
//

import SwiftUI

struct OnboardingHeaderView: View {

    // MARK: - BODY
    var body: some View {
        VStack(spacing: 5) {
            Text(Constants.General.appName)
                .font(.system(size: 48))
                .kerning(Constants.TextStyle.kerning)
                .fontDesign(.rounded)
                .fontWeight(.heavy)
                .foregroundColor(Constants.AppColors.brandPrimary)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
                .accessibilityIdentifier("OnboardingAppName")

            Text(Constants.General.appSubTitle)
                .font(.title)
                .kerning(Constants.TextStyle.kerning)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .foregroundColor(Constants.AppColors.brandPrimary)
                .multilineTextAlignment(.center)
                .accessibilityIdentifier("OnboardingAppSubTitle")
        }
    }
}

// MARK: - PREVIEW
struct OnboardingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingHeaderView()
    }
}
