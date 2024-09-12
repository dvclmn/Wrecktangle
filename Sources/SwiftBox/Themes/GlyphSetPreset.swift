//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

public extension SwiftBox.GlyphSet {

  static let sharp = SwiftBox.GlyphSet(set: [
    .horizontalExterior: "━",
    .horizontalInterior: "─",
    .verticalExterior: "┃",
    .verticalInterior: "│",
    .joinLeading: "┯",
    .joinTrailing: "┷",
    .joinTop: "┠",
    .joinBottom: "┨",
    .joinCross: "┼",
    .cornerTopLeading: "┏",
    .cornerTopTrailing: "┓",
    .cornerBottomLeading: "┗",
    .cornerBottomTrailing: "┛"
  ])

  static let rounded = SwiftBox.GlyphSet(set: [
    
    .horizontalExterior: "─",
    .horizontalInterior: "─",
    .verticalExterior: "│",
    .verticalInterior: "│",
    .joinLeading: "┬",
    .joinTrailing: "┴",
    .joinTop: "├",
    .joinBottom: "┤",
    .joinCross: "┼",
    .cornerTopLeading: "╭",
    .cornerTopTrailing: "╮",
    .cornerBottomLeading: "╰",
    .cornerBottomTrailing: "╯"
    
  ])
  
  static let double = SwiftBox.GlyphSet(set: [
    
    .horizontalExterior: "═",
    .horizontalInterior: "─",
    .verticalExterior: "║",
    .verticalInterior: "│",
    .joinLeading: "╤",
    .joinTrailing: "╧",
    .joinTop: "╟",
    .joinBottom: "╢",
    .joinCross: "┼",
    .cornerTopLeading: "╔",
    .cornerTopTrailing: "╗",
    .cornerBottomLeading: "╚",
    .cornerBottomTrailing: "╝"
  ])

}


