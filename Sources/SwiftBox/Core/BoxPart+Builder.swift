//
//  PartBuilder.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

import TextCore

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
  
  private static func swapCharacters(
    in grid: MultilineString,
    with theme: SwiftBox.Theme
  ) -> MultilineString {
    return grid.map { row in
      row.map { char in
        glyph(char, set: theme.glyphSet)
      }
    }
  }
  
  private static func glyph(_ representative: Character, set: SwiftBox.GlyphSet) -> Character {
    let archetypeSet: SwiftBox.GlyphSet = .sharp
    
    // Create a reverse mapping of Character to PartType for the archetype set
    let reverseMap = Dictionary(uniqueKeysWithValues: archetypeSet.glyphMap.map { ($1, $0) })
    
    // Find the PartType for the representative character
    if let glyphType = reverseMap[representative] {
      // Return the corresponding character from the user's chosen set
      return set.character(for: glyphType.toPartType)
    }
    
    // If no match is found, return the original character
    return representative
  }

  
  
}
