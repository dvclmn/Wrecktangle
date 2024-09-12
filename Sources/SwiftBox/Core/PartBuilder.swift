//
//  PartBuilder.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

public extension SwiftBox {
  
  func partPreset(
    for partType: PartType
  ) -> BoxPart {
    switch self.resolution {
      case .oneByOne:
        return oneByOnePreset(for: partType)
      case .threeByTwo:
        return threeByTwoPreset(for: partType)
    }
  }
  
  private func oneByOnePreset(for partType: PartType) -> BoxPart {
    
    let character: Character
    
    switch partType {
      case .horizontal:
        character = "━"
        
      case .vertical:
        character = "┃"
     
      case .joinLeading:
        character = "├"
        
      case .joinTrailing:
        character = "┤"
        
      case .joinTop:
        character = "┬"
        
      case .joinBottom:
        character = "┴"
        
      case .joinCross:
        character = "┼"
        
        
        /// Corners
        ///
      case .cornerTopLeading:
        character = "┌"
        
      case .cornerTopTrailing:
        character = "┐"
        
      case .cornerBottomLeading:
        character = "└"
        
      case .cornerBottomTrailing:
        character = "┘"
        
    }
    
    var grid = CharacterGrid(columns: 1, rows: 1)
    
    grid[0, 0] = self.glyph(character)
    
    return BoxPart(content: grid, type: partType)
    
  }
  
  private func threeByTwoPreset(for partType: PartType) -> BoxPart {
    
    let layout: [[Character]]
    
    switch partType {

      case .horizontal(.none):
        layout = [
          ["━", "━", "━"],
          ["━", "━", "━"]
        ]
        
      case .horizontal(.top):
        layout = [
          ["━", "━", "━"],
          ["─", "─", "─"]
        ]
        
      case .horizontal(.bottom):
        layout = [
          ["─", "─", "─"],
          ["━", "━", "━"]
        ]
        
      case .vertical(.none):
        layout = [
          ["┃", " ", "┃"],
          ["┃", " ", "┃"]
        ]

      case .vertical(.leading):
        layout = [
          ["┃", " ", "│"],
          ["┃", " ", "│"]
        ]
        
      case .vertical(.trailing):
        layout = [
          ["│", " ", "┃"],
          ["│", " ", "┃"]
        ]
        
      case .joinLeading:
        layout = [
          ["├", "─", "─"],
          ["│", " ", " "]
        ]
      case .joinTrailing:
        layout = [
          ["─", "─", "┤"],
          [" ", " ", "│"]
        ]
      case .joinTop:
        layout = [
          ["┬", "─", "┬"],
          ["│", " ", "│"]
        ]
      case .joinBottom:
        layout = [
          ["│", " ", "│"],
          ["┴", "─", "┴"]
        ]
      case .joinCross:
        layout = [
          ["┼", "─", "┼"],
          ["│", " ", "│"]
        ]
        
        /// Corners
        ///
      case .cornerTopLeading:
        layout = [
          ["┌","━","━"],
          
          ["┃"," ","┌"]
        ]
      case .cornerTopTrailing:
        layout = [
          ["━","━","┐"],
      
          ["┐"," ","┃"]
        ]
      case .cornerBottomLeading:
        layout = [
          ["┃"," ","└"],
      
          ["└","━","━"]
        ]
      case .cornerBottomTrailing:
        layout = [
          ["┘"," ","┃"],
      
          ["━","━","┘"]
        ]
    }

    var grid = CharacterGrid(columns: 3, rows: 2)
    
    for (rowIndex, row) in layout.enumerated() {
      for (columnIndex, char) in row.enumerated() {
        grid[columnIndex, rowIndex] = glyph(char)
      }
    }
    
    return BoxPart(content: grid, type: partType)
  }
  
  private func glyph(_ char: Character) -> Character {
    switch char {
        
      case "━": return glyphSet.character(for: .horizontal)
      case "─": return glyphSet.character(for: .horizontalAlt)
      case "┃": return glyphSet.character(for: .vertical)
      case "│": return glyphSet.character(for: .verticalAlt)
        
      case "├": return glyphSet.character(for: .joinLeading)
      case "┤": return glyphSet.character(for: .joinTrailing)
      case "┬": return glyphSet.character(for: .joinTop)
      case "┴": return glyphSet.character(for: .joinBottom)
      case "┼": return glyphSet.character(for: .joinCross)

      case "┌": return glyphSet.character(for: .cornerTopLeading)
      case "┐": return glyphSet.character(for: .cornerTopTrailing)
      case "└": return glyphSet.character(for: .cornerBottomLeading)
      case "┘": return glyphSet.character(for: .cornerBottomTrailing)
      case " ": return " "
        
      default: return "@" // Default character for undefined glyphs
    }
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
