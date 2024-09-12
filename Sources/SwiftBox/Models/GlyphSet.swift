//
//  GlyphSet.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

public extension SwiftBox {
  
  struct GlyphSet {
    
    private let glyphMap: [BoxGlyph: Character]
    
    init(set: [BoxGlyph: Character]) {
      self.glyphMap = set
    }

    func character(for glyph: BoxGlyph) -> Character {
      return glyphMap[glyph] ?? " "
    }
    
  }
  
}
