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
    header: TestStrings.paragraphs[0],
    content: TestStrings.paragraphs[1],
    config: SwiftBox.Config (
      theme: SwiftBox.Theme(glyphSet: .sharp, frameStyle: .single),
      width: 38,
      headerLineLimit: 1,
      contentLineLimit: 3,
      metrics: .init(widthCounter: .full, lineNumbers: false, invisibles: false)
    )
  )
  
  let box02 = SwiftBox(
    header: TestStrings.conversationTitles[1],
    content: TestStrings.paragraphs[7],
    config: SwiftBox.Config (
      theme: .init(glyphSet: .double, frameStyle: .double),
      width: 38,
      headerLineLimit: 2,
      contentLineLimit: 7,
      metrics: .init(widthCounter: .off, lineNumbers: false, invisibles: false)
    )
  )
  
  
  
  //
  //  let box02 = SwiftBox(
  //    header: TestStrings.conversationTitles[1],
  //    content: TestStrings.paragraphs[7],
  //    config: SwiftBox.Config(
  //      width: 32,
  //      contentLineLimit: 15,
  //      metrics: .init(widthCounter: .off, lineNumbers: true, invisibles: false)
  //    )
  //  )
  //
  //  let box03 = SwiftBox(
  //    header: "",
  //    content: "",
  //    config: SwiftBox.Config(
  //      width: 28,
  //      contentLineLimit: 15,
  //      metrics: .init(widthCounter: .full, lineNumbers: false, invisibles: true)
  //    )
  //  )
  
  var body: some View {
    
    VStack(spacing: 14) {
      
      Text(box01.attributedString)
      Text(box02.attributedString)
      HStack {
        
//        Text("top leading\n" + box01.partPreset(for: .corner(.topLeading), with: .threeByTwo))
//        Text("top trailing\n" + box01.partPreset(for: .corner(.topTrailing), with: .threeByTwo))
//        Text("bottom leading\n" + box01.partPreset(for: .corner(.bottomLeading), with: .threeByTwo))
//        Text("bottom trailing\n" + box01.partPreset(for: .corner(.bottomTrailing), with: .threeByTwo))
      }
//      HStack {
//        Text("Hor. Ext.\n" + box01.partPreset(for: .horizontal(), with: .threeByTwo))
//        Text("Vert. Ext\n" + box01.partPreset(for: .vertical(), with: .threeByTwo))
//      }
//      Text(box02.attributedString)
      
    }
    .textSelection(.enabled)
    
    .monospaced()
    //    .padding(40)
    .frame(width: 370, height: 600)
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

