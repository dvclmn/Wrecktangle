//
//  BoxLine+Render.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

import TextCore

public extension SwiftBox.BoxLine {
  
  var reservedWidth: Int {
    let shadowWidth: Int = theme.shadow.reservedSpace
    
    let capWidth: Int = leadingCap.width + trailingCap.width
    
    let result = capWidth + shadowWidth
    
    return result
  }
  
  func render(
    width: Int,
    theme: SwiftBox.Theme,
    trimMethod: TrimMethod = .leaveSpace,
    errorGlyph: Character = "!" // Probably a better way than this
  ) -> String {
    
    let contentWidth: Int = max(0, width - reservedWidth)
    
    let renderedContent: MultilineString
    
    print("Leading cap: \(leadingCap.content). Trailing cap: \(trailingCap.content)")
    
    switch content {
      case let structuralContent as SwiftBox.StructuralContent:
        let repeatingPart = structuralContent.repeatingPattern.content
        renderedContent = MultilineString.repeatHorizontally(repeatingPart, toWidth: contentWidth)
        
      case let textContent as SwiftBox.TextContent:
        renderedContent = MultilineString([Array(textContent.rawContent)])
        
      default:
        fatalError("Something went wrong when casting as one of the two possible BoxLine types.")
        
    }

    let joinedContent = leadingCap.content.joinHorizontally(with: renderedContent)
      .joinHorizontally(with: trailingCap.content)
    
    return joinedContent.string
    
  }
  
  
}
