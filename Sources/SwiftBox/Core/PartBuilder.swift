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
  
  var resolution: PartPreset.Resolution {
    self.config.theme.frameStyle.resolution
  }
  
  //  func partPreset(
  //    for part: BoxGlyph,
  //    with resolution: PartPreset.Resolution
  //  ) -> PartPreset {
  //
  //    switch resolution {
  //      case .oneByOne:
  //        return oneByOnePreset(for: part)
  //      case .threeByTwo:
  //        return threeByTwoPreset(for: part)
  //    }
  //
  //  }
  //
  //  private func oneByOnePreset(for part: BoxGlyph) -> PartPreset {
  //
  //    var grid = CharacterGrid(rows: 1, columns: 1)
  //    grid[0, 0] = glyphSet.character(for: part)
  //    return PartPreset(content: grid, resolution: .oneByOne)
  //  }
  //
  //  private func threeByTwoPreset(for part: BoxGlyph) -> PartPreset {
  //    var grid = CharacterGrid(rows: 2, columns: 3)
  //
  //    switch part {
  //
  //      case .corner(.topLeading):
  //        grid[0, 0] = glyphSet.character(for: .corner(.topLeading))
  //        grid[0, 1] = glyphSet.character(for: .horizontal(.exterior))
  //        grid[0, 2] = glyphSet.character(for: .horizontal(.exterior))
  //        grid[1, 0] = glyphSet.character(for: .vertical(.exterior))
  //        grid[1, 1] = " "
  //        grid[1, 2] = glyphSet.character(for: .corner(.topLeading))
  //
  //      case .corner(.topTrailing):
  //        grid[0, 0] = glyphSet.character(for: .corner(.topLeading))
  //        grid[0, 1] = glyphSet.character(for: .horizontal(.exterior))
  //        grid[0, 2] = glyphSet.character(for: .horizontal(.exterior))
  //        grid[1, 0] = glyphSet.character(for: .vertical(.exterior))
  //        grid[1, 1] = " "
  //        grid[1, 2] = glyphSet.character(for: .corner(.topLeading))
  //
  //      case .corner(.bottomLeading):
  //        break
  //
  //      case .corner(.bottomTrailing):
  //        break
  //
  //      case .horizontal(_):
  //        break
  //
  //      case .vertical(_):
  //        break
  //
  //      case .join(.top):
  //        break
  //
  //      case .join(.bottom):
  //        break
  //
  //      case .join(.leading):
  //        break
  //
  //      case .join(.trailing):
  //        break
  //
  //      case .join(.cross):
  //        break
  //
  //    }
  //
  //    return PartPreset(content: grid, resolution: .threeByTwo)
  //  }
  //
  
}


public extension SwiftBox.PartPreset {
  
  func constructBoxPart(for line: SwiftBox.BoxLine, width: Int) -> String {
    
    switch (self.resolution, line) {
      case (.oneByOne, _):
        return String(repeating: self.content[0, 0], count: width)
      case (.threeByTwo, .top):
        let left = self.content[0, 0]
        let middle = String(repeating: self.content[0, 1], count: width - 2)
        let right = self.content[0, 2]
        return "\(left)\(middle)\(right)"
      case (.threeByTwo, .bottom):
        let left = self.content[1, 0]
        let middle = String(repeating: self.content[1, 1], count: width - 2)
        let right = self.content[1, 2]
        return "\(left)\(middle)\(right)"
      case (.threeByTwo, .header), (.threeByTwo, .divider), (.threeByTwo, .content):
        let left = self.content[1, 0]
        let middle = String(repeating: " ", count: width - 2)
        let right = self.content[1, 2]
        return "\(left)\(middle)\(right)"
    }
  }
  
}


public extension SwiftBox {
  
  func partPreset(
    for part: BoxGlyph
  ) -> PartPreset {
    switch self.resolution {
      case .oneByOne:
        return oneByOnePreset(for: part)
      case .threeByTwo:
        return threeByTwoPreset(for: part)
    }
  }
  
  private func oneByOnePreset(for part: BoxGlyph) -> PartPreset {
    let char = glyphSet.character(for: part)
    var grid = CharacterGrid(rows: 1, columns: 1)
    grid[0, 0] = char
    return PartPreset(content: grid, resolution: .oneByOne)
  }
  
  private func threeByTwoPreset(for part: BoxGlyph) -> PartPreset {
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
            grid[row, col] = " "
          }
        }
    }
    return PartPreset(content: grid, resolution: .threeByTwo)
  }
  
  
  //    public func buildLine(_ line: BoxLine) -> String {
  //      switch line {
  //        case .top:
  //          return theme.glyphSet.character(for: .corner(.topLeading))
  //            .constructBoxPart(for: line, width: width)
  //        case .bottom:
  //          return theme.glyphSet.character(for: .corner(.bottomLeading))
  //            .constructBoxPart(for: line, width: width)
  //        case .divider:
  //          return theme.glyphSet.character(for: .join(.leading))
  //            .constructBoxPart(for: line, width: width)
  //        case .header, .content:
  //          return theme.glyphSet.character(for: .vertical(.exterior))
  //            .constructBoxPart(for: line, width: width)
  //      }
  //    }
  //
  //    public func buildBox(lines: [BoxLine]) -> String {
  //      return lines.map { buildLine($0) }.joined(separator: "\n")
  //    }
  
}


extension Character {
  func constructBoxPart(for line: SwiftBox.BoxLine, width: Int) -> String {
    let preset = SwiftBox.PartPreset(
      content: SwiftBox.CharacterGrid(rows: 1, columns: 1, defaultValue: self),
      resolution: .oneByOne
    )
    return preset.constructBoxPart(for: line, width: width)
  }
}
