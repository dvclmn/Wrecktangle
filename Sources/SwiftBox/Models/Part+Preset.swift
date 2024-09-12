//
//  Part+Corner.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//

public extension SwiftBox.BoxGlyph {
  
  struct Preset {
    var resolution: Resolution
    var content: CharacterGrid
    
    init(resolution: Resolution, content: CharacterGrid) {
      self.resolution = resolution
      
      precondition(
        content.rows == resolution.rows
        && content.columns == resolution.columns,
        "Content grid size must match resolution"
      )
      
      self.content = content
    }
  }
  
  enum Resolution {
    case oneByOne
    case threeByTwo
    
    var rows: Int {
      switch self {
        case .oneByOne: return 1
        case .threeByTwo: return 2
      }
    }
    
    var columns: Int {
      switch self {
        case .oneByOne: return 1
        case .threeByTwo: return 3
      }
    }
  }
}



public extension SwiftBox {
  
  struct BoxPartPresetFactory {
    let glyphSet: GlyphSet
    
    init(glyphSet: GlyphSet) {
      self.glyphSet = glyphSet
    }
    
    func partPreset(for part: BoxGlyph, with resolution: BoxGlyph.Resolution) -> BoxGlyph.Preset {
      switch resolution {
        case .oneByOne:
          return oneByOnePreset(for: part)
        case .threeByTwo:
          return threeByTwoPreset(for: part)
      }
    }
    
    private func oneByOnePreset(for part: BoxGlyph) -> BoxGlyph.Preset {
      var grid = BoxGlyph.CharacterGrid(rows: 1, columns: 1)
      grid[0, 0] = glyphSet.character(for: part)
      return BoxGlyph.Preset(resolution: .oneByOne, content: grid)
    }
    
    private func threeByTwoPreset(for part: BoxGlyph) -> BoxGlyph.Preset {
      var grid = BoxGlyph.CharacterGrid(rows: 2, columns: 3)
      
      switch part {
          
        case .corner(.topLeading):
          grid[0, 0] = glyphSet.character(for: .corner(.topLeading))
          grid[0, 1] = glyphSet.character(for: .horizontal(.exterior))
          grid[0, 2] = glyphSet.character(for: .horizontal(.exterior))
          grid[1, 0] = glyphSet.character(for: .vertical(.exterior))
          grid[1, 1] = " "
          grid[1, 2] = glyphSet.character(for: .corner(.topLeading))
          
        case .corner(.topTrailing):
          grid[0, 0] = glyphSet.character(for: .corner(.topLeading))
          grid[0, 1] = glyphSet.character(for: .horizontal(.exterior))
          grid[0, 2] = glyphSet.character(for: .horizontal(.exterior))
          grid[1, 0] = glyphSet.character(for: .vertical(.exterior))
          grid[1, 1] = " "
          grid[1, 2] = glyphSet.character(for: .corner(.topLeading))
          
        case .corner(.bottomLeading):
          break
          
        case .corner(.bottomTrailing):
          break
          
        case .horizontal(_):
          break
          
        case .vertical(_):
          break
          
        case .join(.top):
          break
          
        case .join(.bottom):
          break
          
        case .join(.leading):
          break
          
        case .join(.trailing):
          break
          
        case .join(.cross):
          break
          
          

      }
      
      return BoxGlyph.Preset(resolution: .threeByTwo, content: grid)
    }
  }
  

}
