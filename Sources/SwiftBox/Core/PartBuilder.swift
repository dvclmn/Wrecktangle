//
//  PartBuilder.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

public extension SwiftBox {
  
  /// This function provides a way to obtain a part of any resolution (as defined
  /// by the current `SwiftBox` instance Theme settings).
  ///
  func part(_ type: PartType, width: Int? = nil) -> BoxPart {
    
    let theme = self.config.theme
    
    switch theme.frameStyle {
        
        // MARK: - Single frame
      case .single:
        
        /// Single is quite simple, and should just directly obtain the correct `1x1` character
        /// from the user's selected `GlyphSet`, chosen via `Theme`.
        let grid: CharacterGrid = [[theme.glyphSet.character(for: type)]]
        let part = BoxPart(content: grid, type: type)
        return part
        
        
        // MARK: - Double frame
      case .double, .shadow, .intertwined:
        
        let content: CharacterGrid
        
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
        let swappedContent = swapCharacters(in: content)
        
        return BoxPart(content: swappedContent, type: type)
        
    }
    
  }
  
  private func swapCharacters(in grid: CharacterGrid) -> CharacterGrid {
    return grid.map { row in
      row.map { char in
        glyph(char, set: self.glyphSet)
      }
    }
  }
  
  private func glyph(_ representative: Character, set: GlyphSet) -> Character {
    let archetypeSet: GlyphSet = .sharp
    
    // Create a reverse mapping of Character to PartType for the archetype set
    let reverseMap = Dictionary(uniqueKeysWithValues: archetypeSet.glyphMap.map { ($1, $0) })
    
    // Find the PartType for the representative character
    if let partType = reverseMap[representative] {
      // Return the corresponding character from the user's chosen set
      return set.character(for: partType)
    }
    
    // If no match is found, return the original character
    return representative
  }

  
}
