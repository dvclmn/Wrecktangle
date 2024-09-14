//
//  Examples.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import SwiftUI
import BaseHelpers
import TextCore

struct BoxPrintView: View {
  
  let box01 = SwiftBox(
    header: "bottomTrailing",
    content: TestStrings.paragraphs[1],
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
    content: TestStrings.paragraphs[7],
    config: SwiftBox.Config (
      theme: SwiftBox.Theme(glyphSet: .double, frameStyle: .double, shadow: SwiftBox.Theme.Shadow(type: .simple, lightSource: .topLeading, strength: .light)),
      width: 38,
      headerLineLimit: 2,
      contentLineLimit: 7,
      metrics: .init(widthCounter: .compact, lineNumbers: false, invisibles: false)
    )
  )
  
  let boxSmall01 = SwiftBox(
    header: "bottomTrailing",
    content: "TestStrings.paragraphs[6]",
    config: SwiftBox.Config (
      theme: SwiftBox.Theme(
        glyphSet: .double,
        frameStyle: .single,
        shadow: SwiftBox.Theme.Shadow(type: .simple, lightSource: .bottomTrailing, strength: .medium)
      ),
      width: 14,
      contentLineLimit: 3,
      metrics: .init(widthCounter: .off, lineNumbers: false, invisibles: false)
    )
  )
  
  let boxSmall02 = SwiftBox(
    header: "bottomLeading",
    content: TestStrings.paragraphs[6],
    config: SwiftBox.Config (
      theme: SwiftBox.Theme(
        glyphSet: .double,
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
    .frame(width: 370, height: 600)
    .background(.black.opacity(0.6))
    
  }
}

#Preview {
  BoxPrintView()
}

