//
//  BoxPart.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//


extension SwiftBox {
  
  
  public enum BoxPart: Hashable {
    
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
    
    public enum Corner: Hashable {
      
      case top(Top)
      case bottom(Bottom)
      
      public enum Top {
        /// ┏
        case leading
        
        /// ┓
        case trailing
        
      }
      
      public enum Bottom {
        /// ┗
        case leading
        
        /// ┛
        case trailing
        
      }
    }
    
    public enum Location {
      case interior
      case exterior
    }
    
  }
}
