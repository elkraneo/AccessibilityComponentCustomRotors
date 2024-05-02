//
//  ContentView.swift
//  AccessibilityComponentCustomRotors
//
//  Created by Cristian Díaz Peredo on 01.05.24.
//

import RealityKit
import SwiftUI

class CustomEntity1: Entity, HasModel {
  required init() {
    super.init()

    self.model = ModelComponent(
      mesh: .generateSphere(radius: 0.1),
      materials: [SimpleMaterial(color: .purple, isMetallic: false)]
    )

    var accessibilityComponent = AccessibilityComponent()
    accessibilityComponent.isAccessibilityElement = true
    accessibilityComponent.customRotors = [.custom("My Custom Rotor")]
    self.components[AccessibilityComponent.self] = accessibilityComponent

    dump(self)
  }
}

class CustomEntity2: Entity, HasModel {
  required init() {
    super.init()

    self.model = ModelComponent(
      mesh: .generateSphere(radius: 0.1),
      materials: [SimpleMaterial(color: .blue, isMetallic: false)]
    )

    var accessibilityComponent = AccessibilityComponent()
    accessibilityComponent.isAccessibilityElement = true
    accessibilityComponent.customRotors = [.system(.list)]
    accessibilityComponent.traits = [.adjustable]
    self.components[AccessibilityComponent.self] = accessibilityComponent

    dump(self)
  }
}

struct ContentView: View {
  @State private var systemRotorSubscription: EventSubscription?
  @State private var customRotorNavigationSubscription: EventSubscription?
  @State private var customRotorNavigationSubscription2: EventSubscription?

  var body: some View {
    RealityView { content in
      let entity1 = CustomEntity1()
      customRotorNavigationSubscription = content.subscribe(
        to: AccessibilityEvents.RotorNavigation.self,
        on: entity1,
        componentType: AccessibilityComponent.self
      ) { event in
        print("AccessibilityEvents.RotorNavigation")
      }

      entity1.position.x = -0.15
      content.add(entity1)

      //MARK: -

      let entity2 = CustomEntity2()
      systemRotorSubscription = content.subscribe(
        to: AccessibilityEvents.Increment.self,
        on: entity2,
        componentType: AccessibilityComponent.self
      ) { event in
        print("AccessibilityEvents.Increment")
      }
      customRotorNavigationSubscription2 = content.subscribe(
        to: AccessibilityEvents.RotorNavigation.self,
        on: entity2,
        componentType: AccessibilityComponent.self
      ) { event in
        print("AccessibilityEvents.RotorNavigation2")
      }
      entity2.position.x = 0.15
      content.add(entity2)
    }
  }
}

#Preview(windowStyle: .automatic) {
  ContentView()
}
