//
//  BoxLine+Structure.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//

extension BoxLine.Structure {
  
  /// Unless I'm off, this should return a `Character`, not a string
  public func repeatablePart(from glyphSet: SwiftBox.Theme.GlyphSet) -> Character {
    
    /// Exterior parts tend to be visually thicker or stronger
    ///
    let horizontalExterior: Character = SwiftBox.BoxPart.horizontal(.exterior).character(from: glyphSet)
    
    let horizontalInterior: Character = SwiftBox.BoxPart.horizontal(.interior).character(from: glyphSet)
    
    switch self {
        
      case .top:
        return horizontalExterior
        
      case .divider:
        return horizontalInterior
        
      case .bottom:
        return horizontalExterior

    }
  }
  
}
