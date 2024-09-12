//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

public extension SwiftBox.GlyphSet {
  
  static let other = SwiftBox.GlyphSet(set: [
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
  
  
  static let sharp = SwiftBox.GlyphSet(set: [
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
  
  static let sharpThin = SwiftBox.GlyphSet(set: [
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
  
  static let sharpBold = SwiftBox.GlyphSet(set: [
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
  
  static let rounded = SwiftBox.GlyphSet(set: [
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
  
  static let double = SwiftBox.GlyphSet(set: [
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
  
  static let ascii = SwiftBox.GlyphSet(set: [
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
  
  static let dashed = SwiftBox.GlyphSet(set: [
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


