//
//  Examples.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import SwiftUI
//import BaseHelpers
import TextCore

struct BoxExampleView: View {
  
  let box01 = SwiftBox(
    header: "bottomTrailing",
    content: Self.testString,
    config: SwiftBox.Config (
      theme: SwiftBox.Theme(glyphSet: .rounded, frameStyle: .single, shadow: SwiftBox.Theme.Shadow(type: .simple, lightSource: .bottomTrailing, strength: .light)),
      width: 38,
      headerLineLimit: 1,
      contentLineLimit: 3,
      metrics: .init(widthCounter: .full, lineNumbers: false, invisibles: false)
    )
  )
  
  let box02 = SwiftBox(
    header: "lightSource: .topLeading",
    content: Self.testString,
    config: SwiftBox.Config (
      theme: SwiftBox.Theme(glyphSet: .double, frameStyle: .double, shadow: SwiftBox.Theme.Shadow(type: .simple, lightSource: .topLeading, strength: .light)),
      width: 38,
      headerLineLimit: 2,
      contentLineLimit: 4,
      metrics: .init(widthCounter: .compact, lineNumbers: false, invisibles: false)
    )
  )
  
  let boxSmall01 = SwiftBox(
    header: "bottomTrailing",
    content: "TestStrings.paragraphs[6]",
    config: SwiftBox.Config (
      theme: SwiftBox.Theme(
        glyphSet: .rounded,
        frameStyle: .double,
        shadow: SwiftBox.Theme.Shadow(type: .simple, lightSource: .bottomTrailing, strength: .medium)
      ),
      width: 14,
      contentLineLimit: 3,
      metrics: .init(widthCounter: .off, lineNumbers: false, invisibles: false)
    )
  )
  
  let boxSmall02 = SwiftBox(
    header: "bottomLeading",
    content: Self.testString,
    config: SwiftBox.Config (
      theme: SwiftBox.Theme(
        glyphSet: .sharp,
        frameStyle: .single,
        shadow: SwiftBox.Theme.Shadow(type: .simple, lightSource: .bottomLeading, strength: .medium)
      ),
      width: 14,
      contentLineLimit: 5,
      wordWrapStrategy: .wrap,
      metrics: .init(widthCounter: .off, lineNumbers: false, invisibles: false)
    )
  )
  
  
  var body: some View {
    
    VStack(spacing: 14) {
      
      Text(box01.attributedString)
      Text(box02.attributedString)
      
      HStack {
        Text(boxSmall01.attributedString)
        Text(boxSmall02.attributedString)
      }
    }
    .textSelection(.enabled)
    .monospaced()
    .environment(\._lineHeightMultiple, 0.84)
    .frame(width: 370, height: 640)
    .background(.black.opacity(0.6))
    
  }
}

#Preview {
  BoxExampleView()
}

extension BoxExampleView {
  static var testString: String {
  """
  After reviewing your code, I can see a few areas where improvements can be made and why some properties like `labelDisplay` might not be updating correctly. Let's address these issues and suggest some improvements:\n\n1. Repetition between CustomButton and CustomLabel:\n   You're right that there's a lot of repetition. We can solve this by creating a protocol extension for CustomStylable that implements these common methods.\n\n2. Config not updating correctly:\n   The main issue is that you're creating a new instance of the element in each modifier method, but you're not passing the existing configuration to the new instance. This means that each modifier is working on a fresh configuration, losing previous modifications.\n\n3. Improvements and Suggestions:\n\nHere's how we can address these issues:\n\na. Create a protocol extension for
  """
  }
}
