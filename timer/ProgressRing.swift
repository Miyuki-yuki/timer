//
//  ProgressRing.swift
//  timer
//
//  Created by Miyuki Kikuchi on 31/10/2023.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var timeManager: TimeManager
    //@State var progress = 0.0
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            // MARK: Colored Ring
            
            Circle()
                .trim(from: 0.0, to: min(timeManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3843137255, green: 0.5176470588, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4470588235, blue: 0.7137254902, alpha: 1)), Color(#colorLiteral(red: 0.8509803922, green: 0.6862745098, blue: 0.8509803922, alpha: 1)), Color(#colorLiteral(red: 0.5921568627, green: 0.8509803922, blue: 0.8823529412, alpha: 1)), Color(#colorLiteral(red: 0.3843137255, green: 0.5176470588, blue: 1, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0), value: timeManager.progress)
            
            VStack(spacing: 30) {
                // MARK: Elapsed Time
                if timeManager.timeState == .notStarted {
                    
                    VStack(spacing: 5) {
                        Text("Upcoming studying time")
                            .opacity(0.7)
                        
                        Text("\(timeManager.timePlan.TimePeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                } else {
                    
                    //elapsed time
                    VStack(spacing: 5) {
                        Text("Elapsed time (\(timeManager.progress.formatted(.percent)))")
                            .opacity(0.7)
                        
                        Text(timeManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    
                    // Remaining Time
                    VStack(spacing: 5) {
                        if !timeManager.elapsed {
                            Text("Remaining time (\((1 - timeManager.progress).formatted(.percent)))")
                                .opacity(0.7)
                        } else {
                            Text("Extra time")
                                .opacity(0.7)
                        }
                        Text(timeManager.endTime, style: .timer)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
//        .onAppear {
//            progress = 1
//        }
        .onReceive(timer) { _ in
            timeManager.track()
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
            .environmentObject(TimeManager())
    }
    
}
