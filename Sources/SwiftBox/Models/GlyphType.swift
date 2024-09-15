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
      horizontal: Location = .interior,
      vertical: Location = .exterior,
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
    
    
    
//    public static let toPartType: [GlyphType: SwiftBox.PartType] = [
//      .horizontal: .horizontal(),
//      .horizontalAlt: .horizontal(.interior),
//      .vertical: .vertical(),
//      .verticalAlt: .vertical(.interior),
//      .joinLeading: .joinLeading,
//      .joinTrailing: .joinTrailing,
//      .joinTop: .joinTop,
//      .joinBottom: .joinBottom,
//      .joinCross: .joinCross,
//      .cornerTopLeading: .cornerTopLeading,
//      .cornerTopTrailing: .cornerTopTrailing,
//      .cornerBottomLeading: .cornerBottomLeading,
//      .cornerBottomTrailing: .cornerBottomTrailing
//    ]
//    
//    static let fromPartType: [SwiftBox.PartType: GlyphType] = Dictionary(uniqueKeysWithValues: toPartType.map { ($1, $0) })
//    
//    var toPartType: SwiftBox.PartType {
//      return GlyphType.toPartType[self] ?? .horizontal()
//    }
//    
//    public func part(for frameStyle: SwiftBox.Theme.FrameStyle) -> SwiftBox.BoxPart {
//      
//      switch frameStyle {
//        case .single:
//          break
//        case .double:
//          switch self {
//            case .horizontal(.exterior):
//                
//              
//            case .horizontal(.interior):
//              
//            case .vertical(.exterior):
//            case .vertical(.interior):
//              
//            case .join(let horizontal, let vertical, let type):
//              <#code#>
//            case .corner(let location, let type):
//              <#code#>
//          }
//        case .intertwined:
//          break
//      }
//      
//    }
    
  }
}
