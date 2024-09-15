//
//  PartType.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//


public extension SwiftBox {
  
  
  /// I ought to make it so the code will use the external version of a glyph,
  /// if there is no internal style available?
  ///
  enum GlyphType: Hashable {

    case horizontal(Location = .exterior)
    case vertical(Location = .exterior)
    
    case joinLeading            /// ┠
    case joinTrailing           /// ┨
    case joinTop                /// ┯
    case joinBottom             /// ┷
    case joinCross              /// ┼
    
    case cornerTopLeading(Location = .exterior)       /// ┏
    case cornerTopTrailing(Location = .exterior)      /// ┓
    case cornerBottomLeading(Location = .exterior)    /// ┗
    case cornerBottomTrailing(Location = .exterior)   /// ┛
    
    public enum Location {
      case interior
      case exterior
    }
    
    public static let toPartType: [GlyphType: SwiftBox.PartType] = [
      .horizontal: .horizontal(),
      .horizontalAlt: .horizontal(.interior),
      .vertical: .vertical(),
      .verticalAlt: .vertical(.interior),
      .joinLeading: .joinLeading,
      .joinTrailing: .joinTrailing,
      .joinTop: .joinTop,
      .joinBottom: .joinBottom,
      .joinCross: .joinCross,
      .cornerTopLeading: .cornerTopLeading,
      .cornerTopTrailing: .cornerTopTrailing,
      .cornerBottomLeading: .cornerBottomLeading,
      .cornerBottomTrailing: .cornerBottomTrailing
    ]
    
    static let fromPartType: [SwiftBox.PartType: GlyphType] = Dictionary(uniqueKeysWithValues: toPartType.map { ($1, $0) })
    
    var toPartType: SwiftBox.PartType {
      return GlyphType.toPartType[self] ?? .horizontal()
    }
    
    
  }
}
