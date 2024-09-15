//
//  GlyphSet.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

public extension SwiftBox {
  
  enum GlyphSet {
    case base([GlyphType: Character])
    indirect case fallback([GlyphType: Character], GlyphSet)
    
    func character(for glyphType: GlyphType) -> Character {
      switch self {
        case .base(let glyphMap):
          return characterFromMap(glyphMap, for: glyphType) ?? "?"
        case .fallback(let glyphMap, let fallbackSet):
          return characterFromMap(glyphMap, for: glyphType) ?? fallbackSet.character(for: glyphType)
      }
    }
    
    private func characterFromMap(_ glyphMap: [GlyphType: Character], for glyphType: GlyphType) -> Character? {
      if let char = glyphMap[glyphType] {
        return char
      }
      if let fallbackType = glyphType.fallback,
         let fallbackChar = glyphMap[fallbackType] {
        return fallbackChar
      }
      return nil
    }

  }

  
}


