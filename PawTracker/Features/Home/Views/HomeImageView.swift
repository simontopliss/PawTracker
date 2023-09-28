//
//  HomeImageView.swift
//  PawTracker
//
//  Created by Simon Topliss on 14/04/2023.
//

import SwiftUI

struct HomeImageView: View {

    // MARK: - BODY
    @Binding var expand: Bool

    var body: some View {
        Image(Constants.Home.backgroundImageName)
            .resizable()
            .scaledToFit()
            .frame(width: 240)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 4)
            }
            .shadow(
                color: Constants.Shadows.shadowColor,
                radius: 8
            )
            .padding(.bottom, 24)
            .scaleEffect(expand ? 1 : 0.1)
            .onAppear { expand = true }
            .animation(.easeIn, value: expand)
            .accessibilityIdentifier("BackgroundImage")
    }
}

// MARK: - PREVIEW
struct HomeImageView_Previews: PreviewProvider {
    static var previews: some View {
        HomeImageView(expand: .constant(true))
    }
}
