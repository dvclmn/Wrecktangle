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
public typealias Structure = SwiftBox.BoxStructure
public typealias Line = SwiftBox.BoxLine


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
  
  public enum Invisibles {
    case line(LineType)
    case space
    case tab
    case padding
    
    public enum LineType {
      case new
      case end
    }
    
    public var character: String {
      switch self {
        case .line(.new): "¬"
        case .line(.end): "¶"
        case .space: "•"
        case .tab: "→"
        case .padding: ","
      }
    }
  }

  public enum BoxStructure {
    
    case horizontal(Structure.Horizontal)
    case vertical(Structure.Vertical)
    
    public enum Horizontal {
      case top
      case divider
      case bottom
      
      public var corners: (Part, Part)? {
        switch self {
          case .top:
            (Part.corner(.top(.leading)), Part.corner(.top(.trailing)))
          case .divider:
            nil
          case .bottom:
            (Part.corner(.bottom(.leading)), Part.corner(.bottom(.trailing)))
        }
      }

    }
    
    public enum Vertical {
      case leading
      case divider
      case trailing
    }
    
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
    case cross
    
    case corner(Corner)
    
    public enum Join {
      

      public enum Horizontal: Hashable {
        
        case none

        /// ┯
        case top
        
        /// ┷
        case bottom
      }
      
      public enum Vertical: Hashable {
      
        case none
        
        /// ┠
        case leading
        
        /// ┨
        case trailing
      }
      
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
