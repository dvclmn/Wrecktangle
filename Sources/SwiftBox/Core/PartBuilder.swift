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
        
        for (rowIndex, row) in content.enumerated() {
          for (columnIndex, char) in row.enumerated() {
            content[columnIndex, rowIndex] = glyph(char)
          }
        }
        
        return BoxPart(content: content, type: type)
        
    }
    
  }
  
  
  
  
  private func glyph(
    _ representative: Character,
    type: PartType,
    set: GlyphSet
  ) -> Character {
    
    let archetypeSet: GlyphSet = .sharp
    
    
    
    
    
    //        /// The below glyphs are 'representatives', for the other box drawing
    //        /// parts that are the same structure, but in a different style.
    //        ///
    //        /// This allows a more visual way to build part presets, whilst still
    //        /// rendering the final part as per the user's selected Theme.
    //        ///
    //      case "━": glyphSet.character(for: .horizontal(.))
    //      case "─": glyphSet.character(for: .horizontalAlt)
    //      case "┃": glyphSet.character(for: .vertical)
    //      case "│": glyphSet.character(for: .verticalAlt)
    //
    //      case "├": glyphSet.character(for: .joinLeading)
    //      case "┤": glyphSet.character(for: .joinTrailing)
    //      case "┬": glyphSet.character(for: .joinTop)
    //      case "┴": glyphSet.character(for: .joinBottom)
    //      case "┼": glyphSet.character(for: .joinCross)
    //
    //      case "┌": glyphSet.character(for: .cornerTopLeading)
    //      case "┐": glyphSet.character(for: .cornerTopTrailing)
    //      case "└": glyphSet.character(for: .cornerBottomLeading)
    //      case "┘": glyphSet.character(for: .cornerBottomTrailing)
    //      case " ": " "
    //
    //      default: return "@" // Default character for undefined glyphs
    //    }
  }
  
  
}

//
//extension Character {
//  func constructBoxPart(for line: SwiftBox.BoxLine, width: Int) -> String {
//    let preset = SwiftBox.BoxPart(
//      content: SwiftBox.CharacterGrid(rows: 1, columns: 1, defaultValue: self),
//      resolution: .oneByOne
//    )
//    return preset.constructBoxPart(for: line, width: width)
//  }
//}
