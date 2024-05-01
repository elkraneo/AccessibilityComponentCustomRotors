//
//  AccessibilityComponentCustomRotorsApp.swift
//  AccessibilityComponentCustomRotors
//
//  Created by Cristian Díaz Peredo on 01.05.24.
//

import SwiftUI

@main
struct AccessibilityComponentCustomRotorsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
