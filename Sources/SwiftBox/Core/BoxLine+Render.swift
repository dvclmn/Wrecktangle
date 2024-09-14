//
//  BoxLine+Render.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

import TextCore

public extension SwiftBox.BoxLine {

  func render() -> String {

    let renderedContent: MultilineString
    
    print("Leading cap: \(leadingCap.content). Trailing cap: \(trailingCap.content)")
    
    renderedContent = MultilineString(content.rawContent)

    let joinedContent = leadingCap.content + renderedContent + trailingCap.content
    
    return joinedContent.string
    
  }
  
  
}
