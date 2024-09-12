//
//  BoxGlyph.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

public extension SwiftBox {

  
  enum BoxGlyph: Hashable {
    
    case horizontal(Location = .exterior)
    
    case vertical(Location = .exterior)
    
    case join(Join)
    
    case corner(Corner)
    
    
    /// This `Join` struct exists to keep horizontal and vertical joins seperate,
    /// so that `BoxGlyph` cases `horizontal` and `vertical` are
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
      case exterior
      case interior
    }
    
    
    public enum Corner: Hashable {
      /// ┏
      case topLeading
      /// ┓
      case topTrailing
      /// ┗
      case bottomLeading
      /// ┛
      case bottomTrailing
      
    }
    
  }
}

public extension SwiftBox {




}

