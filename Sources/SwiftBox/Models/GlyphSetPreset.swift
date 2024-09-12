//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

public extension SwiftBox {
  
  enum GlyphSetPreset {
    case other
    case sharp
    case sharpThin
    case sharpBold
    case rounded
    case double
    case ascii
    case dashed
    
    var glyphSet: SwiftBox.GlyphSet {
      switch self {
        case .other:
          return SwiftBox.GlyphSet(set: [
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
          return SwiftBox.GlyphSet(set: [
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
        case .sharpThin:
          
          return SwiftBox.GlyphSet(set: [
            .horizontal(.exterior): "─",
            .horizontal(.interior): "─",
            .vertical(.exterior): "│",
            .vertical(.interior): "│",
            .join(.top): "┬",
            .join(.bottom): "┴",
            .join(.leading): "├",
            .join(.trailing): "┤",
            .join(.cross): "┼",
            .corner(.topLeading): "┌",
            .corner(.topTrailing): "┐",
            .corner(.bottomLeading): "└",
            .corner(.bottomTrailing): "┘"
          ])
          
        case .sharpBold:
          
          return SwiftBox.GlyphSet(set: [
            .horizontal(.exterior): "━",
            .horizontal(.interior): "━",
            .vertical(.exterior): "┃",
            .vertical(.interior): "┃",
            .join(.top): "┳",
            .join(.bottom): "┻",
            .join(.leading): "┣",
            .join(.trailing): "┫",
            .join(.cross): "╋",
            .corner(.topLeading): "┏",
            .corner(.topTrailing): "┓",
            .corner(.bottomLeading): "┗",
            .corner(.bottomTrailing): "┛"
          ])
          
        case .rounded:
          
          return SwiftBox.GlyphSet(set: [
            .horizontal(.exterior): "─",
            .horizontal(.interior): "─",
            .vertical(.exterior): "│",
            .vertical(.interior): "│",
            .join(.top): "┬",
            .join(.bottom): "┴",
            .join(.leading): "├",
            .join(.trailing): "┤",
            .join(.cross): "┼",
            .corner(.topLeading): "╭",
            .corner(.topTrailing): "╮",
            .corner(.bottomLeading): "╰",
            .corner(.bottomTrailing): "╯"
          ])
          
        case .double:
          return SwiftBox.GlyphSet(set: [
            .horizontal(.exterior): "═",
            .horizontal(.interior): "─",
            .vertical(.exterior): "║",
            .vertical(.interior): "│",
            .join(.top): "╤",
            .join(.bottom): "╧",
            .join(.leading): "╟",
            .join(.trailing): "╢",
            .join(.cross): "┼",
            .corner(.topLeading): "╔",
            .corner(.topTrailing): "╗",
            .corner(.bottomLeading): "╚",
            .corner(.bottomTrailing): "╝"
          ])
          
        case .ascii:
          
          
          return SwiftBox.GlyphSet(set: [
            .horizontal(.exterior): "-",
            .horizontal(.interior): "-",
            .vertical(.exterior): "|",
            .vertical(.interior): "|",
            .join(.top): "+",
            .join(.bottom): "+",
            .join(.leading): "+",
            .join(.trailing): "+",
            .join(.cross): "+",
            .corner(.topLeading): "+",
            .corner(.topTrailing): "+",
            .corner(.bottomLeading): "+",
            .corner(.bottomTrailing): "+"
          ])
          
        case .dashed:
          return SwiftBox.GlyphSet(set: [
            .horizontal(.exterior): "╌",
            .horizontal(.interior): "╌",
            .vertical(.exterior): "╎",
            .vertical(.interior): "╎",
            .join(.top): "┬",
            .join(.bottom): "┴",
            .join(.leading): "├",
            .join(.trailing): "┤",
            .join(.cross): "┼",
            .corner(.topLeading): "╭",
            .corner(.topTrailing): "┐",
            .corner(.bottomLeading): "└",
            .corner(.bottomTrailing): "╯"
          ])
      }
    }
  } // END Glyphset preset
  
}


