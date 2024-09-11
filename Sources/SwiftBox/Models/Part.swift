//
//  BoxPart.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

public extension SwiftBox {
  
  enum BoxPart: Hashable {
    
    case horizontal(Location = .exterior)
    
    case vertical(Location = .exterior)
    
    case join(Join)
    
    case corner(Corner)
    
    /// This `Join` struct exists to keep horizontal and vertical joins seperate,
    /// so that `BoxPart` cases `horizontal` and `vertical` are
    /// more safely typed.
    ///
    public enum Join {
      
      /// ┠
      case leading
      
      /// ┨
      case trailing
      
      /// ┯
      case top
      
      /// ┷
      case bottom
      
      ///
      case cross
      
      
    }
    

    
    public enum Location {
      case interior
      case exterior
    }
    
  }
}

public extension SwiftBox.BoxPart {
  
  enum PartMode {
    case oneByOne
    case threeByTwo
  }
}


public extension SwiftBox {

  
  /// This provides primary (only?) means to obtain the require `BoxPart`, in the
  /// current user-defined style.
  ///
  func character(for part: SwiftBox.BoxPart) -> Character {
    
    /// This identifies the glyphSet from the selected `Theme`
    ///
    let requestedSet: String = self.config.theme.glyphSet.set
    
    if let index = self.glyphMap[part], index < requestedSet.count {
      
      let startIndex = requestedSet.startIndex
      let requestedGlyphIndex = requestedSet.index(startIndex, offsetBy: index)
      
      let glyph: Character = requestedSet[requestedGlyphIndex]
      
      return glyph
      
    } else {
      fatalError("There was an error retrieving part '\(part)' from the provided GlyphSet '\(requestedSet)'. Please double check the glyph set string and ensure the requested part is present.")
    }
    
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
      
        .corner(.topLeading):       18, /// `┏` corner top leading
      
        .corner(.topTrailing):      20, /// `┓` corner top trailing
      
        .corner(.bottomLeading):    22, /// `┗` corner bottom leading
      
        .corner(.bottomTrailing):   24, /// `┛` corner bottom trailing
      
    ]
    
  }
  
  //  public enum GlyphCount {
  //    case single
  //    case double
  //  }
  //
  
  
}

