//
//  BoxLine+Render.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

public extension SwiftBox.BoxLine {
  
  
  func render(
    width: Int,
    theme: SwiftBox.Theme,
    trimMethod: SwiftBox.TrimMethod = .leaveSpace,
    errorGlyph: Character = "?" // Probably a better way than this
  ) -> String {
    
//    let leadingShadow = shadow
    let contentWidth = width - leadingCap.width - trailingCap.width
    let renderedContent: [[Character]]
    
    switch content {
      case let structuralContent as SwiftBox.StructuralContent:
        renderedContent = structuralContent.render(width: contentWidth, trimMethod: trimMethod)
        
      case let textContent as SwiftBox.TextContent:
        renderedContent = [Array(textContent.rawContent)]
        
      default:
        renderedContent = [[Character]](repeating: [Character](repeating: errorGlyph, count: contentWidth), count: 1)
    }
    
    let outputLines: [String] = renderedContent.enumerated().map { index, row in
      
      let leadingCapRow = index < leadingCap.content.count ? leadingCap.content[index] : [Character](repeating: errorGlyph, count: leadingCap.width)
      let trailingCapRow = index < trailingCap.content.count ? trailingCap.content[index] : [Character](repeating: errorGlyph, count: trailingCap.width)
      
      return String(leadingCapRow + row + trailingCapRow)
    }
    
    return outputLines.joined(separator: "\n")
  }


}

public extension SwiftBox {
  
  func shadowCap(_ side: SwiftBox.BoxSide) -> String {
    
    let result: String = shadow.sideHasShadow(side) ? "\(shadowCharacter)" : ""
    
    return result
    
  }
}
