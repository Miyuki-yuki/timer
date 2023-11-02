//
//  TimeManager.swift
//  timer
//
//  Created by Miyuki Kikuchi on 01/11/2023.
//

import Foundation

enum TimeState {
    case notStarted
    case focusing
    case takingBreak
}
enum TimePlan: String {
    case beginner = "00:15"
    case intermediate = "00:25"
    case advanced = "1:00"
    
    var TimePeriod: Double {
        switch self {
        case .beginner:
            return 0.5
        case .intermediate:
            return 0.15
        case .advanced:
            return 0.25
        }
    }
    
}

class TimeManager: ObservableObject {
    @Published private(set) var timeState: TimeState = .notStarted
    @Published private(set) var timePlan: TimePlan = .intermediate
    @Published private(set) var startTime: Date {
        didSet {
            print("start time", startTime.formatted(.dateTime.month().day().hour().minute().second()))
            
        if timeState == .focusing {
            endTime = startTime.addingTimeInterval(focusTime)
        } else {
            endTime = startTime.addingTimeInterval(breakTime)
        }
     }
    }
    @Published private(set) var endTime: Date {
        didSet {
            print("end time", endTime.formatted(.dateTime.month().day().hour().minute().second()))
        }
    }
    @Published private(set) var elapsed: Bool = false
    @Published private(set) var elapsedTime: Double = 0.0
    @Published private(set) var progress: Double = 0.0
    
    
    var focusTime: Double {
        return timePlan.TimePeriod * 60 * 60
    }
    var breakTime: Double {
        return (24 - timePlan.TimePeriod) * 60 * 60
    }
    
    init() {
        let calendar = Calendar.current
        
//        var components = calendar.dateComponents([.year, .month, .day, .hour], from: Date())
//        components.hour = 20
//        print(components)
//        
//        let scheduledTime = calendar.date(from: components) ?? Date.now
//
        
        let components = DateComponents(hour: 20)
        let scheduledTime = calendar.nextDate(after: .now, matching: components, matchingPolicy: .nextTime)!
        print("scheduled time", scheduledTime.formatted(.dateTime.month().day().hour().minute().second()))
        startTime = scheduledTime
        endTime = scheduledTime.addingTimeInterval(TimePlan.beginner.TimePeriod * 60 * 60)
        
    }
    
    func toggleTimeState() {
        timeState = timeState == .focusing ? .takingBreak : .focusing
        startTime = Date()
        
    }
    
    func track() {
        guard timeState != .notStarted else {
            return
        }
        print("now", Date().formatted(.dateTime.month().day().hour().minute().second()))
        
        if endTime >= Date() {
            print("Not elapsed")
            elapsed = false
        } else {
            print("elapsed")
            elapsed = true
        }
        elapsedTime += 1
        print("elapsedTime", elapsedTime)
        
        let totalTime = timeState == .focusing ? focusTime : breakTime
        progress = (elapsedTime / totalTime * 100 ) .rounded() / 100
        print("progress", progress)
    }

}
