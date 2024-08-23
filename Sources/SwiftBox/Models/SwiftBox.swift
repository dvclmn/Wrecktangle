//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

public typealias Theme = SwiftBox.Theme
public typealias Config = SwiftBox.Configuration
public typealias Part = SwiftBox.FramePart
public typealias Line = SwiftBox.BoxLine
public typealias GlyphStyle = SwiftBox.Theme.GlyphStyle


public struct SwiftBox {
  
  var header: String
  var content: String
  var config: Config
  
  var attributedString: AttributedString {
    return self.drawBox()
  }
  
  public init(
    header: String,
    content: String,
    config: Config = .init()
  ) {
    self.header = header
    self.content = content
    self.config = config
  }
  
  /// Currently this implementaiton can only handle horizontal dividers, not vertical.
  /// So we can process line-by-line vertically in a fairly straightforward way.
  ///
  public enum BoxLine {
    case top
    case header
    case divider
    case content
    case bottom
  }
  
  

  public enum FramePart: Hashable {
    
    case horizontal(
      join: Join.Horizontal = .none,
      location: Location = .exterior
    )
    
    case vertical(
      join: Join.Vertical = .none,
      location: Location = .exterior
    )
    
    case join
    
    case cross
    
    case corner(Corner)
    
    /// This `Join` struct exists to keep horizontal and vertical joins seperate,
    /// so that `FramePart` cases `horizontal` and `vertical` are
    /// more safely typed.
    ///
    public enum Join {
      
      
      case none
      
      /// ┠
      case leading
      
      /// ┨
      case trailing
      /// ┯
      case top
      
      /// ┷
      case bottom
      
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
