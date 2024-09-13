//
//  PartType.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//


public extension SwiftBox {
  
  enum GlyphType: Hashable {
    
    case horizontal
    case horizontalAlt
    case vertical
    case verticalAlt
    
    case joinLeading            /// ┠
    case joinTrailing           /// ┨
    case joinTop                /// ┯
    case joinBottom             /// ┷
    case joinCross              /// ┼
    
    case cornerTopLeading       /// ┏
    case cornerTopTrailing      /// ┓
    case cornerBottomLeading    /// ┗
    case cornerBottomTrailing   /// ┛
    
    
    
  }
  
  enum PartType: Hashable {
    
    case horizontal(HorizontalLocation = .top)
    case vertical(VerticalLocation = .leading)
    
    case joinLeading
    case joinTrailing
    case joinTop
    case joinBottom
    case joinCross
    
    case cornerTopLeading
    case cornerTopTrailing
    case cornerBottomLeading
    case cornerBottomTrailing
    
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
    
    public var toGlyphType: GlyphType {
      switch self {
        case .horizontal(.top), .horizontal(.bottom):
          GlyphType.horizontal

        case .horizontal(.interior):
          GlyphType.horizontalAlt
          
        case .vertical(.leading), .vertical(.trailing):
          GlyphType.vertical
          
        case .vertical(.interior):
          GlyphType.verticalAlt
          
        case .joinLeading:
          GlyphType.joinLeading
          
        case .joinTrailing:
          GlyphType.joinTrailing
          
        case .joinTop:
          GlyphType.joinTop
          
        case .joinBottom:
          GlyphType.joinBottom
          
        case .joinCross:
          GlyphType.joinCross
          
        case .cornerTopLeading:
          GlyphType.cornerTopLeading
          
        case .cornerTopTrailing:
          GlyphType.cornerTopTrailing
          
        case .cornerBottomLeading:
          GlyphType.cornerBottomLeading
          
        case .cornerBottomTrailing:
          GlyphType.cornerBottomTrailing
          
      }
    }

    
  }
  
  enum LineSegment {
    case capLeading
    case capTrailing
  }
  
}
