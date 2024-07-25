//
//  CircularProgressView.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.blue.opacity(0.5),
                    lineWidth: 30
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.easeOut, value: progress)

        }
    }
}

#Preview {
    CircularProgressView(progress: 0.8)
}
