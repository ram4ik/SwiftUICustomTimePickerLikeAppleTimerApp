//
//  ContentView.swift
//  SwiftUICustomTimePickerLikeAppleTimerApp
//
//  Created by Ramill Ibragimov on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var hour: Int = 2
    @State private var minutes: Int = 30
    @State private var seconds: Int = 25
    
    var body: some View {
        VStack {
            TimePicker(hour: $hour, minutes: $minutes, seconds: $seconds)
                .padding(15)
                .background(.white, in: .rect(cornerRadius: 10))
                .padding(.horizontal, 20)
        }
        .padding(15)
        .navigationTitle("Custom Time Picker")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.15))
    }
}

#Preview {
    ContentView()
}
