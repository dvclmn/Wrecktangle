//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation



public extension SwiftBox.GlyphSet {
  
  typealias GlyphType = SwiftBox.GlyphType
  
  static let sharp = SwiftBox.GlyphSet([
    
    GlyphType.horizontal(.exterior): "━",
    GlyphType.horizontal(.interior): "─",
    ///
    GlyphType.vertical(.exterior): "┃",
    GlyphType.vertical(.interior): "│",
    ///
    GlyphType.join(x: .exterior, y: .interior, type: .top):       "┯",
    GlyphType.join(x: .exterior, y: .interior, type: .bottom):    "┷",
    GlyphType.join(x: .exterior, y: .exterior, type: .leading):   "┠",
    GlyphType.join(x: .exterior, y: .exterior, type: .trailing):  "┨",
    GlyphType.join(x: .interior, y: .interior, type: .cross):     "┼",
    ///
    GlyphType.corner(location: .exterior, type: .topLeading):     "┏",
    GlyphType.corner(location: .exterior, type: .topTrailing):    "┓",
    GlyphType.corner(location: .exterior, type: .bottomLeading):  "┗",
    GlyphType.corner(location: .exterior, type: .bottomTrailing): "┛",
    ///
    GlyphType.corner(location: .interior, type: .topLeading):     "┌",
    GlyphType.corner(location: .interior, type: .topTrailing):    "┐",
    GlyphType.corner(location: .interior, type: .bottomLeading):  "└",
    GlyphType.corner(location: .interior, type: .bottomTrailing): "┘",

  ])
  
  static let rounded = SwiftBox.GlyphSet([
    
    .horizontal: "─",
    .horizontalAlt: "─",
    ///
    .vertical: "│",
    .verticalAlt: "│",
    ///
    .joinLeading: "├",
    .joinTrailing: "┤",
    .joinTop: "┬",
    .joinBottom: "┴",
    .joinCross: "┼",
    ///
    .cornerTopLeading: "╭",
    .cornerTopTrailing: "╮",
    .cornerBottomLeading: "╰",
    .cornerBottomTrailing: "╯"
    
  ])
  
  static let double = SwiftBox.GlyphSet([
    
    .horizontal: "═",
    .horizontalAlt: "─",
    ///
    .vertical: "║",
    .verticalAlt: "│",
    ///
    .joinLeading: "╟",
    .joinTrailing: "╢",
    .joinTop: "╤",
    .joinBottom: "╧",
    .joinCross: "┼",
    ///
    .cornerTopLeading: "╔",
    .cornerTopTrailing: "╗",
    .cornerBottomLeading: "╚",
    .cornerBottomTrailing: "╝"
  ])
  
}


