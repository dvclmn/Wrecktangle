//
//  PartType.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

import SwiftUICore

public extension SwiftBox {
  
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
    
    public var flexibility: PartFlexibility {
      switch self {
        case .horizontal:
            .repeatable(axis: .horizontal)
          
        case .vertical:
            .repeatable(axis: .vertical)
          
        default:
            .fixed
      }
    }
    
    var toGlyphType: SwiftBox.GlyphType {
      switch self {
        case .horizontal(.top), .horizontal(.bottom):
          return .horizontal
          
        case .horizontal(.interior):
          return .horizontalAlt
          
        case .vertical(.leading), .vertical(.trailing):
          return .vertical
          
        case .vertical(.interior):
          return .verticalAlt
          
        default:
          return SwiftBox.GlyphType.fromPartType[self] ?? .horizontal
      }
    } // END to glyph type
  } // END part type
  
  
  enum LineSegment {
    case capLeading
    case capTrailing
  }
  
 
  enum PartFlexibility {
    case repeatable(axis: Axis)
    case fixed
  }
  
  
}

