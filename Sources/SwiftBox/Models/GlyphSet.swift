//
//  GlyphSet.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

public extension SwiftBox {
  
  
  struct GlyphSet {
    
    let glyphMap: [GlyphType: Character]
    
    init(_ set: [GlyphType: Character]) {
      self.glyphMap = set
    }
    
    public func character(for part: PartType) -> Character {
      
      return glyphMap[part.toGlyphType] ?? " "
    }
    
    
  }
  
}
