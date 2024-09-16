//
//  Examples.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import SwiftUI
import TextCore

struct BoxExampleView: View {
  
  #if os(macOS)
  let boxWidth: Int = 38
  #else
  let boxWidth: Int = 27
  #endif
  
  var body: some View {
    
    VStack(spacing: 14) {
      
      Text(box01.attributedString)
//      Text(box02.attributedString)
      
//      HStack {
//        Text(boxSmall01.attributedString)
//        Text(boxSmall02.attributedString)
//      }
    }
    .preferredColorScheme(.dark)
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
  
  
  
  var box01: Box {
    Box(
      header: "I love boxes made of text",
      content: Self.testString,
      width: boxWidth,
      glyphSet: .rounded,
      frameStyle: .double,
      widthCounter: .compact
    )
  }
  
//  let box02 = BoxCore(
//    header: "lightSource: .topLeading",
//    content: Self.testString,
//    config: BoxCore.Config (
//      theme: BoxCore.Theme(glyphSet: .double, frameStyle: .double, shadow: BoxCore.Theme.Shadow(type: .simple, lightSource: .topLeading, strength: .light)),
//      width: boxWidth,
//      headerLineLimit: 2,
//      contentLineLimit: 4,
//      metrics: .init(widthCounter: .compact, lineNumbers: false, invisibles: false)
//    )
//  )
//  
//  let boxSmall01 = BoxCore(
//    header: "bottomTrailing",
//    content: "TestStrings.paragraphs[6]",
//    config: BoxCore.Config (
//      theme: BoxCore.Theme(
//        glyphSet: .rounded,
//        frameStyle: .double,
//        shadow: BoxCore.Theme.Shadow(type: .simple, lightSource: .bottomTrailing, strength: .medium)
//      ),
//      width: 14,
//      contentLineLimit: 3,
//      metrics: .init(widthCounter: .off, lineNumbers: false, invisibles: false)
//    )
//  )
//  
//  let boxSmall02 = BoxCore(
//    header: "bottomLeading",
//    content: Self.testString,
//    config: BoxCore.Config (
//      theme: BoxCore.Theme(
//        glyphSet: .sharp,
//        frameStyle: .single,
//        shadow: BoxCore.Theme.Shadow(type: .simple, lightSource: .bottomLeading, strength: .medium)
//      ),
//      width: 14,
//      contentLineLimit: 5,
//      wordWrapStrategy: .wrap,
//      metrics: .init(widthCounter: .off, lineNumbers: false, invisibles: false)
//    )
//  )
  
  
  
  static var testString: String {
  """
  let top = line(.top)
    output.appendString(top, addsLineBreak: true)
    
    /// Header
    if let headerText = self.header {
      
      let headerLines: [String] = headerText.reflowText(
        width: widthLeftForText,
        maxLines: config.headerLineLimit,
        paddingWidth: self.config.theme.padding,
        paddingCharacter: invisibleIfNeeded(.space),
        wrappingOption: self.config.wordWrapStrategy
      )
      
      for headerLine in headerLines {
        let boxLine = line(.text(content: headerLine, lineLimit: config.headerLineLimit))
        output.appendString(boxLine, addsLineBreak: true)
      }
    }
    
  """
  }
}
