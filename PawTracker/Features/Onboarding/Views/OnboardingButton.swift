//
//  OnboardingButton.swift
//  PawTracker
//
//  Created by Simon Topliss on 26/03/2023.
//

import SwiftUI

struct OnboardingButton: View {

    // MARK: - PROPERTIES
    @Binding var showOnboardingView: Bool

    var body: some View {
        HStack {
            Spacer()

            Button {
                showOnboardingView = true
            } label: {
                Image(systemName: Constants.Home.showOnBoardingButtonName)
                    .font(.title)
                    .foregroundColor(Constants.AppColors.brandPrimary)
            }
            .accessibilityIdentifier("OnboardingButton")

        }// HStack
        .padding(.trailing)
    }
}

// MARK: - PREVIEW
struct OnboardingButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingButton(showOnboardingView: .constant(false))
    }
}
