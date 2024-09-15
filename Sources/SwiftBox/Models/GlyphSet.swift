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
    
    func character(for glyphType: SwiftBox.GlyphType) -> Character {
      return glyphMap[glyphType] ?? "?"
    }

  }
  
}
