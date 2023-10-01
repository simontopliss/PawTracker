//
//  FeatureRowView.swift
//  PawTracker
//
//  Created by Simon Topliss on 25/02/2023.
//

import SwiftUI

struct FeatureRowView: View {

    // MARK: - PROPERTIES
    var feature: Feature

    // MARK: - BODY
    var body: some View {
        HStack {
            Text(feature.title)
                .font(.title2)
                .kerning(Constants.TextStyle.kerning)
                .lineLimit(1)
                .fontDesign(.rounded)
                .fontWeight(.heavy)
                .frame(
                    width: Constants.Onboarding.titleWidth,
                    height: Constants.Onboarding.titleHeight
                )
                .shadow(
                    color: Constants.Shadows.shadowColor,
                    radius: Constants.Shadows.smallRadius,
                    x: Constants.Shadows.smallX,
                    y: Constants.Shadows.smallY
                )
                .padding(Constants.Onboarding.featurePadding)
                .foregroundColor(.white)
                .background(LinearGradientRectView())
                .cornerRadius(Constants.Onboarding.cornerRadius)
                .accessibilityIdentifier("FeatureRow_Title")

            Text(feature.description)
                .font(.subheadline)
                .fontDesign(.rounded)
                .lineLimit(3)
                .foregroundColor(Constants.AppColors.textColor)
                .frame(
                    maxWidth: Constants.Onboarding.descriptionMaxWidth,
                    alignment: .leading
                )
                .padding(Constants.Onboarding.featurePadding)
                .accessibilityIdentifier("FeatureRow_Description")
        }
        .frame(minHeight: Constants.Onboarding.featureFrameHeight)
    }
}

// MARK: - PREVIEW
struct FeatureRowView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureRowView(feature: Feature.allFeatures[0])
            .padding()
    }
}
