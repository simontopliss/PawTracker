//
//  LargePetNameView.swift
//  PawTracker
//
//  Created by Simon Topliss on 01/05/2023.
//

import SwiftUI

struct LargeTitleView: View {

    // MARK: - PROPERTIES
    var title: String

    // MARK: - BODY
    var body: some View {
        Text(title)
            .font(.system(size: 48))
            .kerning(Constants.TextStyle.kerning)
            .fontDesign(.rounded)
            .fontWeight(.heavy)
            .foregroundColor(Constants.AppColors.brandPrimary)
            .shadow(
                color: Constants.Shadows.shadowColor,
                radius: Constants.Shadows.largeRadius,
                x: Constants.Shadows.largeX,
                y: Constants.Shadows.largeY
            )
            .accessibilityIdentifier("LargeTitleView")
    }
}

// MARK: - PREVIEW
struct LargePetNameView_Previews: PreviewProvider {
    static var previews: some View {
        LargeTitleView(title: "Fluffy")
    }
}
