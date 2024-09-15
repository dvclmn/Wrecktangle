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
    case join(JoinType)
    case corner(CornerType)
    
    
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

public extension SwiftBox {
  
  /// This should be able to replace the old method, using 'archetype' glyphs
  /// that would then need to be swapped in.
  ///
  /// ```
  /// case .horizontal(.top):
  ///   content = [
  ///     ["━"],
  ///     ["─"]
  ///   ]
  /// ```
  ///
  func partPreset(for partType: PartType) -> [[GlyphType]] {
    switch partType {
      case .horizontal(.top):
        [
          [GlyphType.horizontal(.exterior)],
          [GlyphType.horizontal(.interior)],
        ]
        
      case .horizontal(.bottom):
        [
          [GlyphType.horizontal(.interior)],
          [GlyphType.horizontal(.exterior)],
        ]
        
      case .horizontal(.interior):
        [
          [GlyphType.horizontal(.interior)],
        ]
        
      case .vertical(.leading):
        [
          [GlyphType.vertical(.exterior), GlyphType.blank, GlyphType.vertical(.interior)],
        ]
        
      case .vertical(.trailing):
        [
          [GlyphType.vertical(.interior), GlyphType.blank, GlyphType.vertical(.exterior)],
        ]
      case .vertical(.interior):
        [
          [GlyphType.vertical(.interior)],
        ]
        
      case .join(let joinType):
        switch joinType {
          case .leading:
            [[
              GlyphType.vertical(.exterior),
              GlyphType.blank,
              /// I can use `joinType` directly here, as `PartType` and `GlyphType`
              /// share the same type for describing joins
              GlyphType.join(horizontal: .interior, vertical: .interior, type: joinType),
            ]]
            
          case .trailing:
            [[
              GlyphType.join(horizontal: .interior, vertical: .interior, type: joinType),
              GlyphType.blank,
              GlyphType.vertical(.exterior),
            ]]
            
          case .top:
            [
              [GlyphType.horizontal(.exterior)],
              [GlyphType.join(horizontal: .interior, vertical: .interior, type: joinType)],
            ]
          case .bottom:
            [
              [GlyphType.join(horizontal: .interior, vertical: .interior, type: joinType)],
              [GlyphType.horizontal(.exterior)],
            ]
          case .cross:
            [[GlyphType.join(horizontal: .interior, vertical: .interior, type: joinType)]]
        }
        
      case .corner(let cornerType):
        switch cornerType {
            
            /// # Example
            ///
            ///
            /// ```
            /// ["┏","━","━"],
            ///
            /// ["┃"," ","┌"]
            ///
            /// // Output:
            /// ┏━━
            /// ┃ ┌
            ///
            /// ```
            ///
          case .topLeading:
            [
              [
                GlyphType.corner(location: .exterior, type: cornerType),
                GlyphType.horizontal(.exterior),
                GlyphType.horizontal(.exterior)
              ],
              [
                GlyphType.vertical(.exterior),
                GlyphType.blank,
                GlyphType.corner(location: .interior, type: cornerType)
              ],
            ]
            
          case .topTrailing:
            [
              [
                GlyphType.horizontal(.exterior),
                GlyphType.horizontal(.exterior),
                GlyphType.corner(location: .exterior, type: cornerType),
              ],
              [
                GlyphType.corner(location: .interior, type: cornerType),
                GlyphType.blank,
                GlyphType.vertical(.exterior),
              ],
            ]
            
          case .bottomLeading:
            [
              [
                GlyphType.vertical(.exterior),
                GlyphType.blank,
                GlyphType.corner(location: .interior, type: cornerType)
              ],
              [
                GlyphType.corner(location: .exterior, type: cornerType),
                GlyphType.horizontal(.exterior),
                GlyphType.horizontal(.exterior)
              ],
            ]
          case .bottomTrailing:
            [
              [
                GlyphType.corner(location: .interior, type: cornerType),
                GlyphType.blank,
                GlyphType.vertical(.exterior),
              ],
              [
                GlyphType.horizontal(.exterior),
                GlyphType.horizontal(.exterior),
                GlyphType.corner(location: .exterior, type: cornerType),
              ],
            ]
        }
    }
  }
  
}

