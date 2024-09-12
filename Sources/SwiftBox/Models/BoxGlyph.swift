//
//  BoxGlyph.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

public extension SwiftBox {
  
  /// `BoxGlyph`: A single `Character`. Smallest unit in a box drawing.
  /// Limited to a 1x1 resolution. Does not directly describe structure.
  ///
  /// `BoxPart`: A part used to build a certain portion of a structure,
  /// e.g. a corner, or a vertical wall. Can be any resolution, and thus
  /// made up of more than one `Character`.
  
  
  

  enum BoxGlyph: Hashable {
    
    case horizontal(Location = .exterior)
    case vertical(Location = .exterior)
    case join(Join)
    case corner(Corner)
    
    public enum Join {
      case leading    /// ┠
      case trailing   /// ┨
      case top        /// ┯
      case bottom     /// ┷
      case cross      /// ┼
    }
    
    public enum Location {
      case exterior
      case interior
    }
    
    public enum Corner: Hashable {
      case topLeading       /// ┏
      case topTrailing      /// ┓
      case bottomLeading    /// ┗
      case bottomTrailing   /// ┛
    }
  }
}

