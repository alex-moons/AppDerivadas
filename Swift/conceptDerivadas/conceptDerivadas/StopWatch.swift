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
                HStack(spacing: 3) {
                    StopwatchUnit(timeUnit: hours)
                    Text(":")
                        .font(.system(size: 40))
                        .offset(y: -3)
                    StopwatchUnit(timeUnit: minutes)
                    Text(":")
                        .font(.system(size: 40))
                        .offset(y: -3)
                    StopwatchUnit(timeUnit: seconds)
                }

                HStack {
                    Button(action: {
                        if isRunning{
                            timer?.invalidate()
                        } else {
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                                progressTime += 1
                            })
                        }
                        isRunning.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 80, height: 15, alignment: .center)
                                .foregroundColor(isRunning ? .pink : .green)

                            Text(isRunning ? "Stop" : "Start")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                    }

                    Button(action: {
                        progressTime = 0
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 80, height: 15, alignment: .center)
                                .foregroundColor(.gray)

                            Text("Reset")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
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
                HStack(spacing: 1) {
                    Text(timeUnitStr.substring(index: 0))
                        .font(.system(size: 32))
                        .frame(width: 20)
                    Text(timeUnitStr.substring(index: 1))
                        .font(.system(size: 32))
                        .frame(width: 20)
                }
            }
        }
    }

    struct Stopwatch_Previews: PreviewProvider {
        static var previews: some View {
            StopWatch()
        }
    }

    extension String {
        func substring(index: Int) -> String {
            let arrayString = Array(self)
            return String(arrayString[index])
        }
    }
