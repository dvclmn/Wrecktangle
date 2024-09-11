//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

public extension SwiftBox.Theme {
  
  
  
  struct GlyphSet {
    
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


//public extension SwiftBox {
  
//  public protocol BoxFrame {
//    func glyph(for part: SwiftBox.BoxPart) -> String
//  }
//  
//  public struct CustomBoxFrame: BoxFrame {
//    
//    private let glyphMap: [BoxPart: String]
//    
//    public init(glyphMap: [BoxPart: String]) {
//      self.glyphMap = glyphMap
//    }
//    
//    public func glyph(for part: BoxPart) -> String {
//      return glyphMap[part] ?? " "
//    }
//  }
//  
//}

//public extension SwiftBox.BoxFrame where Self == SwiftBox.CustomBoxFrame {
  
//  public static var singleLine: BoxFrame {
//    SwiftBox.CustomBoxFrame(glyphMap: [
//      .horizontal(): "─",
//      .vertical(): "│",
//      .corner(.topLeading): "┌",
//      .corner(.topTrailing): "┐",
//      .corner(.bottomLeading): "└",
//      .corner(.bottomTrailing): "┘",
//      .join(.top): "┬",
//      .join(.bottom): "┴",
//      .join(.leading): "├",
//      .join(.trailing): "┤",
//      .join(.cross): "┼"
//    ])
//  }
//  
//  public static var doubleLine: BoxFrame {
//    CustomBoxFrame(glyphMap: [
//      .horizontal(): "═",
//      .vertical(): "║",
//      .corner(.topLeft): "╔",
//      .corner(.topRight): "╗",
//      .corner(.bottomLeft): "╚",
//      .corner(.bottomRight): "╝",
//      .join(.top): "╦",
//      .join(.bottom): "╩",
//      .join(.left): "╠",
//      .join(.right): "╣",
//      .join(.cross): "╬"
//    ])
//  }
//}


