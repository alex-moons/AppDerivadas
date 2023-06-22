//
//  StopWatch.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import SwiftUI

struct StopWatch: View {
    /// Current progress time expresed in seconds
        @State private var progressTime = 0
        @State private var isRunning = false
        @Binding var parentProgressTime: Int
    
        /// Computed properties to get the progressTime in hh:mm:ss format
        var hours: Int {
            progressTime / 3600
        }

        var minutes: Int {
            (progressTime % 3600) / 60
        }

        var seconds: Int {
            progressTime % 60
        }

        /// Increase progressTime each second
        @State private var timer: Timer?

        var body: some View {
            VStack {
                HStack(spacing: 0) {
                    StopwatchUnit(timeUnit: hours)
                    Text(":")
                        .font(.system(size: 20))
                        .offset(y: -1)
                    StopwatchUnit(timeUnit: minutes)
                    Text(":")
                        .font(.system(size: 20))
                        .offset(y: -1)
                    StopwatchUnit(timeUnit: seconds)
                }
            }
            .onAppear{
                startstop()
            }
            .onDisappear{
                parentProgressTime = progressTime
                startstop()
            }
        }
        func startstop(){
            if isRunning{
                timer?.invalidate()
            } else {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                    progressTime += 1
                })
            }
            isRunning.toggle()
        }
    }


    struct StopwatchUnit: View {

        var timeUnit: Int

        /// Time unit expressed as String.
        /// - Includes "0" as prefix if this is less than 10.
        var timeUnitStr: String {
            let timeUnitStr = String(timeUnit)
            return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
        }

        var body: some View {
            VStack {
                HStack(spacing: 0) {
                    Text(timeUnitStr.substring(index: 0))
                        .font(.system(size: 16))
                        .frame(width: 10)
                    Text(timeUnitStr.substring(index: 1))
                        .font(.system(size: 16))
                        .frame(width: 10)
                }
            }
        }
    }

    struct Stopwatch_Previews: PreviewProvider {
        static var previews: some View {
            StopWatch(parentProgressTime: .constant(0))
        }
    }

    extension String {
        func substring(index: Int) -> String {
            let arrayString = Array(self)
            return String(arrayString[index])
        }
    }
