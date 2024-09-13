//
//  GlyphSet.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

public extension SwiftBox {
  
  
  struct GlyphSet {
    
    private let glyphMap: [PartType: Character]
    
    init(set: [PartType: Character]) {
      self.glyphMap = set
    }
    
    public func character(for glyph: PartType) -> Character {
      return glyphMap[glyph] ?? " "
    }
    
  }
  
}
