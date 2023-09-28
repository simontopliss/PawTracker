//
//  LinearGradientRectView.swift
//  PawTracker
//
//  Created by Simon Topliss on 18/02/2023.
//

import SwiftUI

struct LinearGradientRectView: View {

    // MARK: - BODY
    var body: some View {
        Rectangle()
            .fill(Constants.AppColors.brandPrimary)
            .overlay {
                LinearGradient(
                    gradient: Gradient(
                        colors: [Color.white.opacity(0.2), Color.black.opacity(0.2)]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
    }
}

// MARK: - PREVIEW
struct LinearGradientRectView_Previews: PreviewProvider {
    static var previews: some View {
        LinearGradientRectView()
    }
}
