//
//  BoxLine+Structural.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

import TextCore

public extension SwiftBox.BoxLine {

  struct StructuralContent: LineContent {
    public let rawContent: String
    
    init(
      adjustedWidth: Int,
      repeatingPattern: SwiftBox.BoxPart
    ) {

      let contentString = repeatingPattern.content.repeatHorizontally(toWidth: adjustedWidth)
      self.rawContent = contentString.string
    }

  }
}
