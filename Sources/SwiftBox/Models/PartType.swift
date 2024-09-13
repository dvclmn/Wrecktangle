//
//  PartType.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//


public extension SwiftBox {
  
  enum PartType: Hashable {
    
    case horizontal(HorizontalLocation = .top)
    case vertical(VerticalLocation = .leading)
    
    case joinLeading            /// ┠
    case joinTrailing           /// ┨
    case joinTop                /// ┯
    case joinBottom             /// ┷
    case joinCross              /// ┼
    
    case cornerTopLeading       /// ┏
    case cornerTopTrailing      /// ┓
    case cornerBottomLeading    /// ┗
    case cornerBottomTrailing   /// ┛
    
    public enum HorizontalLocation: Hashable {
      case top
      case bottom
      case interior // Divider
    }
    
    public enum VerticalLocation: Hashable {
      case leading
      case trailing
      case interior // Divider
    }

    
  }
  
  enum LineSegment {
    case capLeading
    case capTrailing
  }
  
}
