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
    
//    switch partType {
//      case .horizontal:
//        <#code#>
//      case .vertical:
//        <#code#>
//      case .joinLeading:
//        <#code#>
//      case .joinTrailing:
//        <#code#>
//      case .joinTop:
//        <#code#>
//      case .joinBottom:
//        <#code#>
//      case .joinCross:
//        <#code#>
//      case .cornerTopLeading:
//        <#code#>
//      case .cornerTopTrailing:
//        <#code#>
//      case .cornerBottomLeading:
//        <#code#>
//      case .cornerBottomTrailing:
//        <#code#>
//    }
//    
//    let char = glyphSet.character(for: part)
//    var grid = CharacterGrid(rows: 1, columns: 1)
//    grid[0, 0] = char
    fatalError("Not implemented yet")
//    return BoxPart(content: CharacterGrid(rows: 1, columns: 1), resolution: .oneByOne, type: partType)
  }
  
  private func threeByTwoPreset(for partType: PartType) -> BoxPart {
    var grid = CharacterGrid(rows: 2, columns: 3)
    switch partType {
        
      case .horizontal:
        /// First row
        grid[0, 0] = glyphSet.character(for: .horizontalExterior)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .horizontalExterior)
        grid[1, 1] = glyphSet.character(for: .horizontalExterior)
        grid[1, 2] = glyphSet.character(for: .horizontalExterior)
        
      case .vertical:
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)
        
      case .joinLeading:
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)
        
      case .joinTrailing:
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)
        
      case .joinTop:
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)
        
      case .joinBottom:
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)
        
      case .joinCross:
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)
        
      case .cornerTopLeading:
      
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)

      case .cornerTopTrailing:
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)

        
      case .cornerBottomLeading:
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)
        
      case .cornerBottomTrailing:
        /// First row
        grid[0, 0] = glyphSet.character(for: .cornerTopLeading)
        grid[0, 1] = glyphSet.character(for: .horizontalExterior)
        grid[0, 2] = glyphSet.character(for: .horizontalExterior)
        /// Second row
        grid[1, 0] = glyphSet.character(for: .verticalExterior)
        grid[1, 1] = " "
        grid[1, 2] = glyphSet.character(for: .cornerTopLeading)
    }
    return BoxPart(content: grid, resolution: .threeByTwo, type: partType)
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
