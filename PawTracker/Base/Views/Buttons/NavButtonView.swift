//
//  NavButtonView.swift
//  PawTracker
//
//  Created by Simon Topliss on 27/02/2023.
//

import SwiftUI

struct NavButtonView: View {

    // MARK: - PROPERTIES
    var title: String
    var arrow: String
    var colorVariant: Color

    // MARK: - BODY
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .fontDesign(.rounded)
                .fontWeight(.bold)

            Image(systemName: arrow)
                .imageScale(.large)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 10)
        .background(
            Capsule().strokeBorder(
                colorVariant,
                lineWidth: 2.0
            )
        )
        .foregroundColor(colorVariant)
    }
}

// MARK: - PREVIEW
struct NavButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavButtonView(
            title: "My Pets",
            arrow: "arrow.right.circle",
            colorVariant: .white
        )
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
