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

    /// I need to get clear on which parts of this package really rely
    /// on which *other* parts. This `character` function is very
    /// important — and I think `BoxGlyph` might use it the most?
    ///
    public func character(for glyph: BoxGlyph) -> Character {
      return glyphMap[glyph] ?? " "
    }
    
  }
  
}
