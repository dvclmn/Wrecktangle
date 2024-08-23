//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

extension Theme {
  public enum GlyphSet {
    
    case rounded
    case sharp
    case double
    case ascii
    case bold
    case dashed
    
    public var string: String {
      switch self {
          //                 0 0 0 0 0 1 1 1 1 1 2 2 2
          //                 0 2 4 6 8 0 2 4 6 8 0 2 4
        case .rounded:    "━ ─ ┯ ┷ ┃ │ ┠ ┨ ┼ ╭ ╮ ╰ ╯"
          
        case .sharp:      "─ ─ ┬ ┴ │ │ ├ ┤ ┼ ┌ ┐ └ ┘"
          
        case .double:     "═ ─ ╤ ╧ ║ │ ╟ ╢ ┼ ╔ ╗ ╚ ╝"
          
        case .ascii:      "- - + + | | + + + + + + +"
          
        case .bold:       "━ ━ ┳ ┻ ┃ ┃ ┣ ┫ ╋ ┏ ┓ ┗ ┛"
          
        case .dashed:     "╌ ╌ ┬ ┴ ╎ ╎ ├ ┤ ┼ ╭ ╮ ╰ ╯"
          
      }
    }
    
  } // END glyph set
}
