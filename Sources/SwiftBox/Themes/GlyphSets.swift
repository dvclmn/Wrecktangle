//
//  Glyphs.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

extension Theme {

  public struct GlyphSet {
    
    var set: String
    
    public init(set: String) {
      self.set = set
    }
    
    //                                             0 0 0 0 0 1 1 1 1 1 2 2 2
    //                                             0 2 4 6 8 0 2 4 6 8 0 2 4
    public static let rounded =     GlyphSet(set: "━ ─ ┃ │ ┯ ┷ ┠ ┨ ┼ ╭ ╮ ╰ ╯")
    
    public static let sharp =       GlyphSet(set: "─ ─ │ │ ┬ ┴ ├ ┤ ┼ ┌ ┐ └ ┘")
    
    public static let double =      GlyphSet(set: "═ ─ ║ │ ╤ ╧ ╟ ╢ ┼ ╔ ╗ ╚ ╝")
    
    public static let ascii =       GlyphSet(set: "- - | | + + + + + + + + +")
    
    public static let bold =        GlyphSet(set: "━ ━ ┃ ┃ ┳ ┻ ┣ ┫ ╋ ┏ ┓ ┗ ┛")
    
    public static let dashed =      GlyphSet(set: "╌ ╌ ╎ ╎ ┬ ┴ ├ ┤ ┼ ╭ ╮ ╰ ╯")
    
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
      case .horizontal(.exterior):          return 00 /// `━` horizontal exterior
      case .horizontal(.interior):          return 02 /// `─` horizontal interior

      case .vertical(.exterior):            return 04 /// `┃` vertical exterior
      case .vertical(.interior):            return 06 /// `│` vertical interior
        
      case .join(let join):
        switch join {
          case .top:                        return 00 /// `┯` join top
          case .bottom:                     return 02 /// `┷` join bottom
          case .leading:                    return 00 /// `┠` join leading
          case .trailing:                   return 02 /// `┨` join trailing
          case .cross:                      return 00 /// `┼` join cross
        }
        
      case .corner(.top(.leading)):         return 18 /// `╭` corner top leading
      case .corner(.top(.trailing)):        return 20 /// `╮` corner top trailing
      case .corner(.bottom(.leading)):      return 22 /// `╰` corner bottom leading
      case .corner(.bottom(.trailing)):     return 24 /// `╯` corner bottom trailing
    }
  }
  
  /// This provides primary (only?) means to obtain the require `Part`, in the
  /// current user-defined style.
  ///
  public func character(with config: Config, container: AttributeContainer? = nil) -> AttributedString {
    
    var output = AttributedString()

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
