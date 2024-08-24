//
//  Characters.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUI

extension SwiftBox {
  
  
  public enum Invisibles {
    case line(LineType)
    case space
    case tab
    case padding
    case paddingAlt
    
    public enum LineType {
      case new
      case end
    }
    
    public var character: Character {
      switch self {
        case .line(.new): "¬"
        case .line(.end): "¶"
        case .space: "•"
        case .tab: "→"
        case .padding: ","
        case .paddingAlt: "."
      }
    }
  }
  
}

extension SwiftBox.BoxPart {
  
  /// This provides primary (only?) means to obtain the require `BoxPart`, in the
  /// current user-defined style.
  ///
  public func character(
    with config: SwiftBox.Config,
    container: AttributeContainer? = nil
  ) -> AttributedString {
    
    var output = AttributedString()
    
    /// This identifies the glyphSet from the selected `Theme`
    ///
    let glyphSet = config.theme.glyphSet.set
    
    if let index = glyphMap[self], index < glyphSet.count {
      let glyph = String(glyphSet[glyphSet.index(glyphSet.startIndex, offsetBy: index)])
      output.appendString(glyph)
    }
    
    if let container = container {
      output.setAttributes(container)
    }
    return output
  }
  
  
  
  
  /// `SwiftBox` keeps `GlyphSet` definitions light and easy(ish) to read, by enforcing
  /// a specific order to the supplied definition string.
  ///
  /// The effect is similar to a spritesheet in game/web development. Instead of xy coordinates
  /// to identify each entity, we use an index of type `Int`. The convention for this 'lookup'
  /// style is defined below.
  ///
  
  /// See ``BoxPart`` for more information on the structural elements used to make boxes.
  ///
  
  private var glyphMap: [SwiftBox.BoxPart: Int] {
    
    [
      .horizontal(.exterior):     00, /// `━` horizontal exterior
      .horizontal(.interior):     02, /// `─` horizontal interior
      .vertical(.exterior):       04, /// `┃` vertical exterior
      .vertical(.interior):       06, /// `│` vertical interior
      .join(.top):                08, /// `┯` join top
      .join(.bottom):             10, /// `┷` join bottom
      .join(.leading):            12, /// `┠` join leading
      .join(.trailing):           14, /// `┨` join trailing
      .join(.cross):              16, /// `┼` join cross
      .corner(.topLeading):       18, /// `╭` corner top leading
      .corner(.topTrailing):      20, /// `╮` corner top trailing
      .corner(.bottomLeading):    22, /// `╰` corner bottom leading
      .corner(.bottomTrailing):   24, /// `╯` corner bottom trailing
    ]
    
  }
  
  //  public enum GlyphCount {
  //    case single
  //    case double
  //  }
  //
  
  
}

