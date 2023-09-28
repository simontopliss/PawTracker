//
//  TodayFeedsColumnsHeader.swift
//  PawTracker
//
//  Created by Simon Topliss on 02/05/2023.
//

import SwiftUI

struct TodayFeedsColumnsHeader: View {

    // MARK: - BODY
    var body: some View {
        HStack(alignment: .lastTextBaseline) {

            Text("Today’s Feeds")
                .font(.headline)
                .fontDesign(.rounded)
                .bold()
                .multilineTextAlignment(.leading)
                .foregroundColor(Constants.AppColors.textColor)
                .accessibilityIdentifier("TodayFeedsView_Title")

            Group {
                Spacer()
                Text("Morning")
                    .accessibilityIdentifier("TodayFeedsView_MorningColumnHeader")
                Spacer()
                Text("Lunch")
                    .accessibilityIdentifier("TodayFeedsView_LunchColumnHeader")
                Spacer()
                Text("Evening")
                    .accessibilityIdentifier("TodayFeedsView_EveningColumnHeader")
                Spacer()
            }
            .font(.footnote)
            .fontDesign(.rounded)
            .foregroundColor(Constants.AppColors.textColor)
        }
    }
}

// MARK: - PREVIEW
struct TodayFeedsColumnsHeader_Previews: PreviewProvider {
    static var previews: some View {
        TodayFeedsColumnsHeader()
            .padding()
    }
}
