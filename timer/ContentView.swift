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
        ZStack{
            VStack(spacing: 40) {
                //title
                Text("Let's start!")
                    .font(.headline)
                    .foregroundStyle(Color(#colorLiteral(red: 0.3843137255, green: 0.5176470588, blue: 1, alpha: 1)))
                //
                
                Text("16:8")
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
                
                HStack(spacing: 60) {
                    //start time
                    VStack(spacing: 5) {
                        Text("Start")
                            .opacity(0.7)
                        Text(Date(), format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    //end time
                    VStack(spacing: 5) {
                        Text("End")
                            .opacity(0.7)
                        Text(Date().addingTimeInterval(16), format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                //Button
                Button {
                    
                }label: {
                    Text("start")
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
