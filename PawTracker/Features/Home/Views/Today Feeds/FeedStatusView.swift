//
//  FeedStatusView.swift
//  PawTracker
//
//  Created by Simon Topliss on 05/05/2023.
//

import SwiftUI

struct FeedStatusView: View {

    // MARK: - PROPERTIES
    @Binding var status: Bool

    // MARK: - BODY
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: status ? 2 : 0)
                .foregroundColor(status ? Constants.AppColors.brandPrimary : .clear)
                .frame(width: 44)
            if status {
                Circle()
                    .fill(Constants.AppColors.brandPrimary)
                    .frame(width: 34)
            } else {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Constants.AppColors.brandPrimary.opacity(0.5))
                    .frame(width: 14)
            }
        }
        .onTapGesture {
            withAnimation {
                status.toggle()
            }
        }
    }
}

// MARK: - PREVIEW
struct FeedStatusView_Previews: PreviewProvider {
    static var previews: some View {
        FeedStatusView(status: .constant(true))
    }
}
