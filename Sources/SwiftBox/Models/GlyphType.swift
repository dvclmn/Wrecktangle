//
//  PartType.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//


public extension SwiftBox {
  
  enum JoinType: Hashable {
    case leading
    case trailing
    case top
    case bottom
    case cross
  }
  
  enum CornerType: Hashable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
  }
  
  /// I ought to make it so the code will use the external version of a glyph,
  /// if there is no internal style available?
  ///
  enum GlyphType: Hashable {
    
    /// Basic lines
    case horizontal(Location = .exterior)
    case vertical(Location = .exterior)
    
    /// Joins
    case join(
      x: Location = .interior,
      y: Location = .exterior,
      type: JoinType
    )
    
    /// Corners
    case corner(
      location: Location = .exterior,
      type: CornerType
    )
    
    case blank
    
    public enum Location: Hashable {
      case interior
      case exterior
    }
    
    var fallback: SwiftBox.GlyphType? {
      switch self {
        case .horizontal(.interior):
          return .horizontal(.exterior)
        case .vertical(.interior):
          return .vertical(.exterior)
        case .join(let x, let y, _):
          return .join(x: x, y: y, type: .cross) // Default to cross join
        case .corner(_, let type):
          return .corner(location: .exterior, type: type) // Default to top-leading corner
        default:
          return nil
      }
    }
  }
    
}
