//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

extension Theme {
  
  /// `━` horizontal exterior
  ///
  /// `─` horizontal interior
  ///
  /// `┯` horizontal join top
  ///
  /// `┷` horizontal join bottom
  ///
  ///
  /// `┃` vertical exterior
  ///
  /// `│` vertical interior
  ///
  /// `┠` vertical join leading
  ///
  /// `┨` vertical join trailing
  ///
  ///
  /// `┼` cross join
  ///
  ///
  /// `╭` corner top leading
  ///
  /// `╮` corner top trailing
  ///
  /// `╰` corner bottom leading
  ///
  /// `╯` corner bottom trailing
  ///
  
  
  public struct GlyphSet {
    
    var set: String
    
    public init(set: String) {
      self.set = set
    }
    
    //                                             0 0 0 0 0 1 1 1 1 1 2 2 2
    //                                             0 2 4 6 8 0 2 4 6 8 0 2 4
    public static let rounded =     GlyphSet(set: "━ ─ ┯ ┷ ┃ │ ┠ ┨ ┼ ╭ ╮ ╰ ╯")
    
    public static let sharp =       GlyphSet(set: "─ ─ ┬ ┴ │ │ ├ ┤ ┼ ┌ ┐ └ ┘")
    
    public static let double =      GlyphSet(set: "═ ─ ╤ ╧ ║ │ ╟ ╢ ┼ ╔ ╗ ╚ ╝")
    
    public static let ascii =       GlyphSet(set: "- - + + | | + + + + + + +")
    
    public static let bold =        GlyphSet(set: "━ ━ ┳ ┻ ┃ ┃ ┣ ┫ ╋ ┏ ┓ ┗ ┛")
    
    public static let dashed =      GlyphSet(set: "╌ ╌ ┬ ┴ ╎ ╎ ├ ┤ ┼ ╭ ╮ ╰ ╯")
    
  } // END glyph set
}

/// `SwiftBox` keeps `GlyphSet` definitions light and easy(ish) to read, by enforcing
/// a specific order to the supplied definition string.
///
/// The effect is similar to a spritesheet in game/web development. Instead of xy coordinates
/// to identify each entity, we use an index of type `Int`. The convention for this 'lookup'
/// style is defined below.
///
extension Part {
  
  /// See ``Part`` for more information on the structural elements used to make boxes.
  ///
  public var themeIndex: Int {
    switch self {
      case .horizontal(join: .none, location: .exterior):   return 0
      case .horizontal(join: .none, location: .interior):   return 2
      case .horizontal(join: .top, location: .exterior):                      return 4
      case .horizontal(join: .bottom, location: .exterior):                   return 6
        
      case .vertical(join: .none, location: .exterior):     return 8
      case .vertical(join: .none, location: .interior):     return 10
      case .vertical(join: .leading, _):                    return 12
      case .vertical(join: .trailing, _):                   return 14
        
      case .cross:                                          return 16
        
      case .corner(.top(.leading)):                         return 18
      case .corner(.top(.trailing)):                        return 20
      case .corner(.bottom(.leading)):                      return 22
      case .corner(.bottom(.trailing)):                     return 24
    }
  }
  
  /// This provides primary (only?) means to obtain the require `Part`, in the
  /// current user-defined style.
  ///
  public func character(with config: Config, container: AttributeContainer? = nil) -> AttributedString {
    
    var output = AttributedString("")

    /// This identifies the glyphSet from the selected `Theme`
    ///
    let glyphSet: String = config.theme.glyphSet.set
    let glyphIndex: String.Index = glyphSet.index(glyphSet.startIndex, offsetBy: self.themeIndex)
    let glyph = String(glyphSet[glyphIndex])
    
    output.appendString(glyph)
    
    if let container = container {
      output.setAttributes(container)
    }
    
    return output
  }
  
}
