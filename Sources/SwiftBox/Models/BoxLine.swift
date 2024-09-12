//
//  Line.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//


/// Currently this library can only handle horizontal dividers, not vertical.
/// So processing line-by-line, vertically, is fairly strightforward.
///
public extension SwiftBox {
  
  enum BoxLine {
    
    case top
    case header
    case divider
    case content
    case bottom
    
    public var isStructural: Bool {
      switch self {
        case .top, .divider, .bottom:
          true
        default:
          false
      }
    }
    
  }
}
