//
//  ContentView.swift
//  timer
//
//  Created by Miyuki Kikuchi on 31/10/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var timeManager = TimeManager()
    
    var title: String {
        switch timeManager.timeState {
        case .notStarted:
            return "Let's get started!"
        case .focusing:
            return "You are focusing."
        case .takingBreak:
            return "You are on a break."
        }
    }
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.05024140328, green: 0.006751002744, blue: 0.08163713664, alpha: 1))
                .ignoresSafeArea()
            content
        }
    }
    var content: some View {
        ZStack{
            VStack(spacing: 40) {
                //title
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Color(#colorLiteral(red: 0.3843137255, green: 0.5176470588, blue: 1, alpha: 1)))
                //
                
                Text(timeManager.timePlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                //add spacer to push them to the top
                Spacer()
            }
            .padding()
            
            VStack(spacing: 40) {
                //progress ring
                
                ProgressRing()
                    .environmentObject(timeManager)
                
                HStack(spacing: 60) {
                    //start time
                    VStack(spacing: 5) {
                        Text(timeManager.timeState == .notStarted ? "Start" : "Started")
                            .opacity(0.7)
                        Text(timeManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    //end time
                    VStack(spacing: 5) {
                        Text(timeManager.timeState == .notStarted ? "End" : "Ends")
                            .opacity(0.7)
                        Text(timeManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                //Button
                Button {
                    timeManager.toggleTimeState()
                }label: {
                    Text(timeManager.timeState == .focusing ? "End" : "Start")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                    
                }
            }
            .padding()
           
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    ContentView()
}
