//
//  ContentView.swift
//  timer
//
//  Created by Miyuki Kikuchi on 31/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.05024140328, green: 0.006751002744, blue: 0.08163713664, alpha: 1))
                .ignoresSafeArea()
            content
        }
    }
    var content: some View {
        VStack(spacing: 40) {
            // MARK: Progress Ring
            
            ProgressRing()
        }
    }
}

#Preview {
    ContentView()
}
