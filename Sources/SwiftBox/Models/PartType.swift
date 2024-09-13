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
    
    /// This is useful (although possibly expensive? I will need to test) for
    /// providing a way to get the resolution for any part. This was made
    /// to assist with calculating correct shadow values.
    ///
    func resolution(with theme: Theme) -> Resolution {
      let part = BoxPart.create(self, theme: theme)
      let width = part.width
      let height = part.height
      
      return Resolution(width: width, height: height)
    }
    
    var toGlyphType: GlyphType {
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
          return GlyphType.fromPartType[self] ?? .horizontal
      }
    } // END to glyph type
  } // END part type
  
  
  enum LineSegment {
    case capLeading
    case capTrailing
  }
  
  struct Resolution {
    var width: Int
    var height: Int
  }
  
}
