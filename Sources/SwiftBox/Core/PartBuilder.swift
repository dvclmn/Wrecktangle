//
//  PartBuilder.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

public extension SwiftBox {
  
  var glyphSet: GlyphSet {
    self.config.theme.glyphSet
  }
  
  var resolution: BoxPart.Resolution {
    self.config.theme.frameStyle.resolution
  }
 
}


//public extension SwiftBox.BoxPart {
//  
//  func constructBoxPart(
//    for line: SwiftBox.BoxLine,
//    width: Int
//  ) -> String {
//    
//    switch (self.resolution, line) {
//      case (.oneByOne, _):
//        return String(repeating: self.content[0, 0], count: width)
//        
//      case (.threeByTwo, .top):
//        let left = self.content[0, 0]
//        let middle = String(repeating: self.content[0, 1], count: width - 2)
//        let right = self.content[0, 2]
//        return "\(left)\(middle)\(right)"
//        
//      case (.threeByTwo, .bottom):
//        let left = self.content[1, 0]
//        let middle = String(repeating: self.content[1, 1], count: width - 2)
//        let right = self.content[1, 2]
//        return "\(left)\(middle)\(right)"
//        
//      case (.threeByTwo, .header), (.threeByTwo, .divider), (.threeByTwo, .content):
//        let left = self.content[1, 0]
//        let middle = String(repeating: " ", count: width - 2)
//        let right = self.content[1, 2]
//        return "\(left)\(middle)\(right)"
//        
//    }
//  }
//  
//}


public extension SwiftBox {
  
  func partPreset(
    for part: BoxGlyph
  ) -> BoxPart {
    switch self.resolution {
      case .oneByOne:
        return oneByOnePreset(for: part)
      case .threeByTwo:
        return threeByTwoPreset(for: part)
    }
  }
  
  private func oneByOnePreset(for part: BoxGlyph) -> BoxPart {
    let char = glyphSet.character(for: part)
    var grid = CharacterGrid(rows: 1, columns: 1)
    grid[0, 0] = char
    return BoxPart(content: grid, resolution: .oneByOne)
  }
  
  private func threeByTwoPreset(for part: BoxGlyph) -> BoxPart {
    var grid = CharacterGrid(rows: 2, columns: 3)
    switch part {
      case .corner(.topLeading):
        /// First row
        grid[0, 0] = glyphSet.character(for: .corner(.topLeading))
        grid[0, 1] = glyphSet.character(for: .horizontal(.exterior))
        grid[0, 2] = glyphSet.character(for: .horizontal(.exterior))
        /// Second row
        grid[1, 0] = glyphSet.character(for: .vertical(.exterior))
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .corner(.topLeading))
        
      case .corner(.topTrailing):
        /// First row
        grid[0, 0] = glyphSet.character(for: .corner(.topLeading))
        grid[0, 1] = glyphSet.character(for: .horizontal(.exterior))
        grid[0, 2] = glyphSet.character(for: .horizontal(.exterior))
        /// Second row
        grid[1, 0] = glyphSet.character(for: .vertical(.exterior))
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .corner(.topLeading))
        
      default:
        // Fill with space characters if not implemented
        for row in 0..<2 {
          for col in 0..<3 {
            grid[row, col] = "x"
          }
        }
    }
    return BoxPart(content: grid, resolution: .threeByTwo)
  }

  
}


//extension Character {
//  func constructBoxPart(for line: SwiftBox.BoxLine, width: Int) -> String {
//    let preset = SwiftBox.BoxPart(
//      content: SwiftBox.CharacterGrid(rows: 1, columns: 1, defaultValue: self),
//      resolution: .oneByOne
//    )
//    return preset.constructBoxPart(for: line, width: width)
//  }
//}
