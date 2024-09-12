//
//  GlyphSet.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

public extension SwiftBox {
  
  struct GlyphSet {
    
    /// `SwiftBox` keeps `GlyphSet` definitions light and easy(ish) to read, by enforcing
    /// a specific order to the supplied definition string.
    ///
    /// The effect is similar to a spritesheet in game/web development.
    ///
    /// See ``BoxGlyph`` for more information on the structural elements used to make boxes.
    ///
    
    private let glyphMap: [BoxGlyph: Character]
    
    init(set: String) {
      let glyphs = set.split(separator: " ")
      var map: [BoxGlyph: Character] = [:]
      
      map[.horizontal(.exterior)]     = glyphs[00].first! /// `━` horizontal exterior
      map[.horizontal(.interior)]     = glyphs[01].first! /// `─` horizontal interior
      map[.vertical(.exterior)]       = glyphs[02].first! /// `┃` vertical exterior
      map[.vertical(.interior)]       = glyphs[03].first! /// `│` vertical interior
      
      map[.join(.top)]                = glyphs[04].first! /// `┯` join top
      map[.join(.bottom)]             = glyphs[05].first! /// `┷` join bottom
      map[.join(.leading)]            = glyphs[06].first! /// `┠` join leading
      map[.join(.trailing)]           = glyphs[07].first! /// `┨` join trailing
      map[.join(.cross)]              = glyphs[08].first! /// `┼` join cross
      
      map[.corner(.topLeading)]       = glyphs[09].first! /// `┏` corner top leading
      map[.corner(.topTrailing)]      = glyphs[10].first! /// `┓` corner top trailing
      map[.corner(.bottomLeading)]    = glyphs[11].first! /// `┗` corner bottom leading
      map[.corner(.bottomTrailing)]   = glyphs[12].first! /// `┛` corner bottom trailing
      
      self.glyphMap = map
    }
    
    func character(for glyph: BoxGlyph) -> Character {
      return glyphMap[glyph] ?? " "
    }
  }

}
