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
              Glyph.join(horizontal: .interior, vertical: .interior, type: joinType),
            ]]
            
          case .trailing:
            return [[
              Glyph.join(horizontal: .interior, vertical: .interior, type: joinType),
              Glyph.blank,
              Glyph.vertical(.exterior),
            ]]
            
          case .top:
            return [
              [Glyph.horizontal(.exterior)],
              [Glyph.join(horizontal: .interior, vertical: .interior, type: joinType)],
            ]
          case .bottom:
            return [
              [Glyph.join(horizontal: .interior, vertical: .interior, type: joinType)],
              [Glyph.horizontal(.exterior)],
            ]
          case .cross:
            return [[Glyph.join(horizontal: .interior, vertical: .interior, type: joinType)]]
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
  
  
  /// This function provides a way to obtain a part of any resolution (as defined
  /// by the current `SwiftBox` instance Theme settings).
  ///
  static func create(
    _ type: SwiftBox.PartType,
    theme: SwiftBox.Theme
  ) -> SwiftBox.BoxPart {
    
    switch theme.frameStyle {
        
        // MARK: - Single frame
      case .single:
        
        /// Single is quite simple, and should just directly obtain the correct `1x1` character
        /// from the user's selected `GlyphSet`, chosen via `Theme`.
        let content: MultilineString = [[theme.glyphSet.character(for: type)]]
        let part = SwiftBox.BoxPart(content: content, type: type)
        return part
        
        // MARK: - Double frame
      case .double, .intertwined:
        
        let content: MultilineString
        
        switch type {
            
          case .horizontal(.top):
            content = [
              ["━"],
              ["─"]
            ]
            //            content = [
            //              ["━"],
            //              ["─"]
            //            ]
            
          case .horizontal(.bottom):
            content = [
              ["─"],
              ["━"]
            ]
            
          case .horizontal(.interior):
            content = [
              ["─"]
            ]
            
          case .vertical(.leading):
            content = [
              ["┃", " ", "│"]
            ]
            
          case .vertical(.trailing):
            content = [
              ["│", " ", "┃"]
            ]
            
          case .vertical(.interior):
            content = [
              ["│"]
            ]
            
          case .joinLeading:
            content = [
              ["┃", " ", "├"]
            ]
            
          case .joinTrailing:
            content = [
              ["┤", " ", "┃"]
            ]
          case .joinTop:
            content = [
              ["━"],
              ["┬"]
            ]
          case .joinBottom:
            content = [
              ["┴"],
              
              ["━"]
            ]
          case .joinCross:
            content = [
              ["┼"]
            ]
            
            /// Corners
            ///
          case .cornerTopLeading:
            content = [
              ["┏","━","━"],
              
              ["┃"," ","┌"]
            ]
          case .cornerTopTrailing:
            content = [
              ["━","━","┓"],
              
              ["┐"," ","┃"]
            ]
          case .cornerBottomLeading:
            content = [
              ["┃"," ","└"],
              
              ["┗","━","━"]
            ]
          case .cornerBottomTrailing:
            content = [
              ["┘"," ","┃"],
              
              ["━","━","┛"]
            ]
        }
        
        
        // Perform the hot swapping after the switch
        let swappedContent = swapCharacters(in: content, with: theme)
        
        return SwiftBox.BoxPart(content: swappedContent, type: type)
        
    }
    
  }
  
  
  
  //  private static func swapCharacters(
  //    in grid: MultilineString,
  //    with theme: SwiftBox.Theme
  //  ) -> MultilineString {
  //    let swappedGrid = grid.map { row in
  //      row.map { char in
  //        glyph(char, set: theme.glyphSet)
  //      }
  //    }
  //    return MultilineString(swappedGrid)
  //  }
  //
  //  private static func glyph(_ representative: Character, set: SwiftBox.GlyphSet) -> Character {
  //    let archetypeSet: SwiftBox.GlyphSet = .sharp
  //
  //    // Create a reverse mapping of Character to PartType for the archetype set
  //    let reverseMap = Dictionary(uniqueKeysWithValues: archetypeSet.glyphMap.map { ($1, $0) })
  //
  //    // Find the PartType for the representative character
  //    if let glyphType = reverseMap[representative] {
  //      // Return the corresponding character from the user's chosen set
  //      return set.character(for: glyphType.toPartType)
  //    } else {
  //      print("Could not find glyph, returning representative: \(representative)")
  //      return representative
  //    }
  //
  //  }
  
  
  
}
