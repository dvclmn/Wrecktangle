//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

public extension SwiftBox {
  
  //                                      0 0 0 0 0 1 1 1 1 1 2 2 2
  //                                      0 2 4 6 8 0 2 4 6 8 0 2 4
//  static let other =       GlyphSet(set: "─ ─ │ │ ┯ ┷ ┠ ┨ ┼ ╱ ╲ ╲ ╱")
//  
//  static let sharp =       GlyphSet(set: "━ ─ ┃ │ ┯ ┷ ┠ ┨ ┼ ┏ ┓ ┗ ┛")
//  
//  static let sharpThin =   GlyphSet(set: "─ ─ │ │ ┬ ┴ ├ ┤ ┼ ┌ ┐ └ ┘")
//  
//  static let sharpBold =   GlyphSet(set: "━ ━ ┃ ┃ ┳ ┻ ┣ ┫ ╋ ┏ ┓ ┗ ┛")
//  
//  static let rounded =     GlyphSet(set: "─ ─ │ │ ┬ ┴ ├ ┤ ┼ ╭ ╮ ╰ ╯")
//  
//  static let double =      GlyphSet(set: "═ ─ ║ │ ╤ ╧ ╟ ╢ ┼ ╔ ╗ ╚ ╝")
//  
//  static let ascii =       GlyphSet(set: "- - | | + + + + + + + + +")
//  
//  static let dashed =      GlyphSet(set: "╌ ╌ ╎ ╎ ┬ ┴ ├ ┤ ┼ ╭ ┐ └ ╯")
//  
  
  enum GlyphSetPreset {
    case other
    case sharp
  
    
    var glyphSet: GlyphSet {
      switch self {
        case .other:
          return GlyphSet(set: [
            .horizontal(.exterior): "─",
            .horizontal(.interior): "─",
            .vertical(.exterior): "│",
            .vertical(.interior): "│",
            .join(.top): "┯",
            .join(.bottom): "┷",
            .join(.leading): "┠",
            .join(.trailing): "┨",
            .join(.cross): "┼",
            .corner(.topLeading): "╱",
            .corner(.topTrailing): "╲",
            .corner(.bottomLeading): "╲",
            .corner(.bottomTrailing): "╱"
          ])
          
        case .sharp:
          return GlyphSet(set: [
            .horizontal(.exterior): "━",
            .horizontal(.interior): "─",
            .vertical(.exterior): "┃",
            .vertical(.interior): "│",
            .join(.top): "┯",
            .join(.bottom): "┷",
            .join(.leading): "┠",
            .join(.trailing): "┨",
            .join(.cross): "┼",
            .corner(.topLeading): "┏",
            .corner(.topTrailing): "┓",
            .corner(.bottomLeading): "┗",
            .corner(.bottomTrailing): "┛"
          ])
      }
    }
  }
  
}


