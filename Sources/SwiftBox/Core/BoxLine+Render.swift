//
//  BoxLine+Render.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

import TextCore

public extension SwiftBox.BoxLine {
  
  
  func render(
    width: Int,
    theme: SwiftBox.Theme,
    trimMethod: TrimMethod = .leaveSpace,
    errorGlyph: Character = "!" // Probably a better way than this
  ) -> String {
    
    
    let contentWidth = width - leadingCap.width - trailingCap.width
    
    let renderedContent: MultilineString
    
    print("Leading cap: \(leadingCap.content). Trailing cap: \(trailingCap.content)")
    
    switch content {
      case let structuralContent as SwiftBox.StructuralContent:
        renderedContent = structuralContent.render(width: contentWidth, trimMethod: trimMethod)
        
      case let textContent as SwiftBox.TextContent:
        renderedContent = [Array(textContent.rawContent)]
        
      default:
        renderedContent = MultilineString(SwiftBox.CharacterGrid(repeating: [Character](repeating: errorGlyph, count: contentWidth), count: 1))

    }
    
    /// I didn't know this until just recently, but if you supply `String` with
    /// an array (or even, as below, multiple concatenated arrays!) of
    /// `[Character]`, Swift will initialise this as... a `String`.
    ///
    /// It makes sense, but it wasn't something I would have assumed until
    /// it was shown to me.
    ///
    /// That's what's happening here:
    /// `String(leadingCapRow + row + trailingCapRow)`
    ///
    
    
    let outputLines: [String] = (0..<renderedContent.height).map { index in
      let leadingCapRow: [Character] = index < leadingCap.content.height ? leadingCap.content[index] : [Character](repeating: errorGlyph, count: leadingCap.width)
      let trailingCapRow: [Character] = index < trailingCap.content.height ? trailingCap.content[index] : [Character](repeating: errorGlyph, count: trailingCap.width)
      
      return String(MultilineString(leadingCapRow) + renderedContent[index] + MultilineString(trailingCapRow))
    }
    
    return outputLines.joined(separator: "\n")

    
    
    let outputLines: [String] = renderedContent.enumerated().map { index, row in
      
      let leadingCapRow: [Character] = index < leadingCap.content.count ? leadingCap.content[index] : [Character](repeating: errorGlyph, count: leadingCap.width)
      let trailingCapRow: [Character] = index < trailingCap.content.count ? trailingCap.content[index] : [Character](repeating: errorGlyph, count: trailingCap.width)
      
      return String(leadingCapRow + row + trailingCapRow)
    }
    
    let result = outputLines.joined(separator: "\n")
    
//    print(result)
    
    return result
  }
  
  
}
