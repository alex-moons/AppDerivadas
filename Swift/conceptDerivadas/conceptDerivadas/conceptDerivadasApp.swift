//
//  conceptDerivadasApp.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI

@main
struct conceptDerivadasApp: App {
    @StateObject var sharedInfo = AppInfo()
    var body: some Scene {
        WindowGroup {
            Home().environmentObject(sharedInfo)
        }
    }
}
