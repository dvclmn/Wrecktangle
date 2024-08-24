//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

extension SwiftBox.Theme {

  public struct GlyphSet {
    
    var set: String
    
    public init(set: String) {
      self.set = set
    }
    
    //                                             0 0 0 0 0 1 1 1 1 1 2 2 2
    //                                             0 2 4 6 8 0 2 4 6 8 0 2 4
    public static let other =       GlyphSet(set: "─ ─ │ │ ┯ ┷ ┠ ┨ ┼ ╱ ╲ ╲ ╱")
    
    public static let sharp =       GlyphSet(set: "━ ─ ┃ │ ┯ ┷ ┠ ┨ ┼ ┏ ┓ ┗ ┛")
    
    public static let sharpThin =   GlyphSet(set: "─ ─ │ │ ┬ ┴ ├ ┤ ┼ ┌ ┐ └ ┘")
    
    public static let sharpBold =   GlyphSet(set: "━ ━ ┃ ┃ ┳ ┻ ┣ ┫ ╋ ┏ ┓ ┗ ┛")
    
    public static let rounded =     GlyphSet(set: "─ ─ │ │ ┬ ┴ ├ ┤ ┼ ╭ ╮ ╰ ╯")
    
    public static let double =      GlyphSet(set: "═ ─ ║ │ ╤ ╧ ╟ ╢ ┼ ╔ ╗ ╚ ╝")
    
    public static let ascii =       GlyphSet(set: "- - | | + + + + + + + + +")
    
    public static let dashed =      GlyphSet(set: "╌ ╌ ╎ ╎ ┬ ┴ ├ ┤ ┼ ╭ ┐ └ ╯")
    
  } // END glyph set
}

