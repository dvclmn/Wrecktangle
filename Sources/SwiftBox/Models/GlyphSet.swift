//
//  GlyphSet.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

public extension SwiftBox {
  
  
  struct GlyphSet {
    
    let glyphMap: [GlyphType: Character]
    let fallbackSet: GlyphSet?
    
    init(
      _ set: [GlyphType: Character],
      fallbackTo: GlyphSet? = nil
    ) {
      self.glyphMap = set
      self.fallbackSet = fallbackTo
    }

    
    func character(for glyphType: SwiftBox.GlyphType) -> Character {
      
      // Try to get the character from this set
      if let char = glyphMap[glyphType] {
        return char
      }
      
      // Try fallback within this set
      if let fallbackType = glyphType.fallback,
         let fallbackChar = glyphMap[fallbackType] {
        return fallbackChar
      }
      
      // If we have a fallback set, try to get the character from there
      if let fallbackSetChar = fallbackSet?.character(for: glyphType) {
        return fallbackSetChar
      }
      
      // If all else fails, return a default character
      return "?"
      
    }
    
  }
  
  
  
}


