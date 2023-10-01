//
//  OnboardingView.swift
//  PawTracker
//
//  Created by Simon Topliss on 17/02/2023.
//

import SwiftUI

struct OnboardingView: View {

    // MARK: - PROPERTIES
    @Binding var isPresented: Bool

    // MARK: - BODY
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                PawTrackerIconView()
                DismissButtonView()
            }

            ScrollView {
                OnboardingHeaderView()

                ForEach(Feature.allFeatures) { feature in
                    FeatureRowView(feature: feature)
                }
            }

        }
        .padding()
    }
}

// MARK: - PREVIEW
struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isPresented: .constant(true))
    }
}
