//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

extension Theme {
  
  public struct GlyphSet {
    
    var set: String
    
    public init(set: String = Self.sharp) {
      self.set = set
    }
    
    //                                     0 0 0 0 0 1 1 1 1 1 2 2 2
    //                                     0 2 4 6 8 0 2 4 6 8 0 2 4
    public static let rounded: String =   "━ ─ ┯ ┷ ┃ │ ┠ ┨ ┼ ╭ ╮ ╰ ╯"
    
    public static let sharp: String =     "─ ─ ┬ ┴ │ │ ├ ┤ ┼ ┌ ┐ └ ┘"
    
    public static let double: String =    "═ ─ ╤ ╧ ║ │ ╟ ╢ ┼ ╔ ╗ ╚ ╝"
    
    public static let ascii: String =     "- - + + | | + + + + + + +"
    
    public static let bold: String =      "━ ━ ┳ ┻ ┃ ┃ ┣ ┫ ╋ ┏ ┓ ┗ ┛"
    
    public static let dashed: String =    "╌ ╌ ┬ ┴ ╎ ╎ ├ ┤ ┼ ╭ ╮ ╰ ╯"
    
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
      case .horizontal(join: .top, _):                      return 4
      case .horizontal(join: .bottom, _):                   return 6
        
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
  public func character(with config: Config) -> String {
    
    /// This identifies the glyphSet from the selected `Theme`
    ///
    let glyphSet: String = config.theme.glyphSet.set
    let glyphIndex: String.Index = glyphSet.index(glyphSet.startIndex, offsetBy: self.themeIndex)
    let glyph = String(glyphSet[glyphIndex])
    
    return glyph
  }
  
}
