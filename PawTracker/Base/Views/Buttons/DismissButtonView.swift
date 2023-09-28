//
//  DismissButtonView.swift
//  PawTracker
//
//  Created by Simon Topliss on 25/02/2023.
//

import SwiftUI

struct DismissButtonView: View {

    // MARK: - PROPERTIES
    @Binding var isPresented: Bool

    // MARK: - BODY
    var body: some View {
        HStack {
            Spacer()

            Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .foregroundColor(.secondary)
            }
            .accessibilityIdentifier("DismissButton")
        }
    }
}

// MARK: - PREVIEW
struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView(isPresented: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
