//
//  Examples.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import SwiftUI
import BaseHelpers

struct BoxPrintView: View {
  
  let box01 = SwiftBox(
    header: TestStrings.paragraphs[0],
    content: TestStrings.paragraphs[1],
    config: SwiftBox.Configuration (
      theme: .init(glyphSet: .double),
      width: 38,
      contentLineLimit: 5,
      metrics: .init(widthCounter: .compact, lineNumbers: true, invisibles: true),
      extraFrame: true
    )
  )
  
  let box02 = SwiftBox(
    header: TestStrings.conversationTitles[1],
    content: TestStrings.paragraphs[7],
    config: SwiftBox.Configuration(
      width: 32,
      contentLineLimit: 15,
      metrics: .init(widthCounter: .full, lineNumbers: true, invisibles: false)
    )
  )
  
  var body: some View {
    
    VStack(spacing: 14) {
      
      Text(box01.attributedString)
      Text(box02.attributedString)
      
    }
    .textSelection(.enabled)
    
    .monospaced()
    //    .padding(40)
    .frame(width: 400, height: 780)
    .background(.black.opacity(0.6))
    
  }
}

extension BoxPrintView {
  //  var string: AttributedString {
  //    var output: AttributedString = ""
  //    SwiftBox(
  //      header: ,
  //      content: ,
  //      config: .default
  //    ) { text in
  //      output = text
  //    }
  //
  //    return output
  //  }
}


#Preview {
  BoxPrintView()
}

