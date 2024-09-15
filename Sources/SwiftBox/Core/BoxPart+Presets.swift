//
//  PartBuilder.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

import TextCore


public extension SwiftBox.PartType {
  
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
  var preset: [[SwiftBox.GlyphType]] {
    
    typealias Glyph = SwiftBox.GlyphType
    
    switch self {
        
      case .horizontal(.top):
        return [
          [Glyph.horizontal(.exterior)],
          [Glyph.horizontal(.interior)],
        ]
        
      case .horizontal(.bottom):
        return [
          [Glyph.horizontal(.interior)],
          [Glyph.horizontal(.exterior)],
        ]
        
      case .horizontal(.interior):
        return [
          [Glyph.horizontal(.interior)],
        ]
        
      case .vertical(.leading):
        return [
          [Glyph.vertical(.exterior), Glyph.blank, Glyph.vertical(.interior)],
        ]
        
      case .vertical(.trailing):
        return [
          [Glyph.vertical(.interior), Glyph.blank, Glyph.vertical(.exterior)],
        ]
      case .vertical(.interior):
        return [
          [Glyph.vertical(.interior)],
        ]
        
      case .join(let joinType):
        switch joinType {
          case .leading:
            return [[
              Glyph.vertical(.exterior),
              Glyph.blank,
              /// I can use `joinType` directly here, as `PartType` and `GlyphType`
              /// share the same type for describing joins
              Glyph.join(x: .interior, y: .interior, type: joinType),
            ]]
            
          case .trailing:
            return [[
              Glyph.join(x: .interior, y: .interior, type: joinType),
              Glyph.blank,
              Glyph.vertical(.exterior),
            ]]
            
          case .top:
            return [
              [Glyph.horizontal(.exterior)],
              [Glyph.join(x: .interior, y: .interior, type: joinType)],
            ]
          case .bottom:
            return [
              [Glyph.join(x: .interior, y: .interior, type: joinType)],
              [Glyph.horizontal(.exterior)],
            ]
          case .cross:
            return [[Glyph.join(x: .interior, y: .interior, type: joinType)]]
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
            return [
              [
                Glyph.corner(location: .exterior, type: cornerType),
                Glyph.horizontal(.exterior),
                Glyph.horizontal(.exterior)
              ],
              [
                Glyph.vertical(.exterior),
                Glyph.blank,
                Glyph.corner(location: .interior, type: cornerType)
              ],
            ]
            
          case .topTrailing:
            return [
              [
                Glyph.horizontal(.exterior),
                Glyph.horizontal(.exterior),
                Glyph.corner(location: .exterior, type: cornerType),
              ],
              [
                Glyph.corner(location: .interior, type: cornerType),
                Glyph.blank,
                Glyph.vertical(.exterior),
              ],
            ]
            
          case .bottomLeading:
            return [
              [
                Glyph.vertical(.exterior),
                Glyph.blank,
                Glyph.corner(location: .interior, type: cornerType)
              ],
              [
                Glyph.corner(location: .exterior, type: cornerType),
                Glyph.horizontal(.exterior),
                Glyph.horizontal(.exterior)
              ],
            ]
          case .bottomTrailing:
            return [
              [
                Glyph.corner(location: .interior, type: cornerType),
                Glyph.blank,
                Glyph.vertical(.exterior),
              ],
              [
                Glyph.horizontal(.exterior),
                Glyph.horizontal(.exterior),
                Glyph.corner(location: .exterior, type: cornerType),
              ],
            ]
        }
    }
  }
  
}




public extension SwiftBox.BoxPart {
 
  static func create(
    from part: SwiftBox.PartType,
    using glyphSet: SwiftBox.GlyphSet
  ) -> SwiftBox.BoxPart {
    
    let glyphGrid = part.preset
    let characterGrid = glyphGrid.map { row in
      row.map { glyphSet.character(for: $0) }
    }
    let multilineString = MultilineString(characterGrid)
    
    print("Character grid:\n \(multilineString)")
    
    return SwiftBox.BoxPart(content: multilineString, type: part)
  }
}
