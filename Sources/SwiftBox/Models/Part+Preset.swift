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

public extension SwiftBox.BoxGlyph {
  
  struct CharacterGrid {
    private var grid: [[Character]]
    let rows: Int
    let columns: Int
    
    init(rows: Int, columns: Int, defaultValue: Character = " ") {
      self.rows = rows
      self.columns = columns
      self.grid = Array(repeating: Array(repeating: defaultValue, count: columns), count: rows)
    }
    
    subscript(row: Int, column: Int) -> Character {
      get {
        precondition(isValidIndex(row: row, column: column), "Index out of range")
        return grid[row][column]
      }
      set {
        precondition(isValidIndex(row: row, column: column), "Index out of range")
        grid[row][column] = newValue
      }
    }
    
    private func isValidIndex(row: Int, column: Int) -> Bool {
      return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    func getRow(_ row: Int) -> [Character] {
      precondition(row >= 0 && row < rows, "Row index out of range")
      return grid[row]
    }
    
    func getColumn(_ column: Int) -> [Character] {
      precondition(column >= 0 && column < columns, "Column index out of range")
      return grid.map { $0[column] }
    }
    
    mutating func setRow(_ row: Int, to characters: [Character]) {
      precondition(row >= 0 && row < rows, "Row index out of range")
      precondition(characters.count == columns, "Invalid number of characters for row")
      grid[row] = characters
    }
    
    mutating func setColumn(_ column: Int, to characters: [Character]) {
      precondition(column >= 0 && column < columns, "Column index out of range")
      precondition(characters.count == rows, "Invalid number of characters for column")
      for (index, char) in characters.enumerated() {
        grid[index][column] = char
      }
    }
  }

  
  func partPreset(
    for part: SwiftBox.BoxGlyph,
    with mode: Resolution
  ) -> Preset {
    
    switch mode {
      case .oneByOne:

        let preset = Preset(resolution: mode, content: CharacterGrid([
          [self.character(for: part)]
        ]))
        
        return preset
        
      case .threeByTwo:
        
    }
    
    switch part {
      case .corner(let cornerType):

            switch cornerType {
              case .topLeading:
                
                var grid = SwiftBox.CharacterGrid()
                
                
                var result: String = ""
                
                /// 3x2 — Top row
                result += character(for: .corner(.topLeading)).string
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .horizontal(.exterior)).string
                result += "\n"
                
                /// 3x2 — Bottom row
                result += character(for: .vertical(.exterior)).string
                result += " "
                result += character(for: .corner(.topLeading)).string

                return result
                
              case .topTrailing:
                var result: String = ""
                
                /// 3x2 — Top row
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .corner(.topTrailing)).string
                result += "\n"
                
                /// 3x2 — Bottom row
                result += character(for: .corner(.topTrailing)).string
                result += " "
                result += character(for: .vertical(.exterior)).string
                
                return result
                
                
              case .bottomLeading:
                var result: String = ""
                
                /// 3x2 — Top row
                result += character(for: .vertical(.exterior)).string
                result += " "
                result += character(for: .corner(.bottomLeading)).string
                result += "\n"
                
                /// 3x2 — Bottom row
                result += character(for: .corner(.bottomLeading)).string
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .horizontal(.exterior)).string
                
                return result
                
                
              case .bottomTrailing:
                var result: String = ""
                
                /// 3x2 — Top row
                result += character(for: .corner(.bottomTrailing)).string
                result += " "
                result += character(for: .vertical(.exterior)).string
                result += "\n"
                
                /// 3x2 — Bottom row
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .corner(.bottomTrailing)).string
                
                return result


            }
            
        
        
      case .horizontal:
        
        var result = ""

            result += character(for: .horizontal(.exterior)).string
            result += "\n"
            result += character(for: .horizontal(.interior)).string
            
            
                
            
            
        
        return result
        
        
        
        
      case .join(let join):
        return ""
        
      case .vertical:
        var result = ""

        result += character(for: .vertical(.exterior)).string
            result += "\n"
            result += character(for: .horizontal(.interior)).string
            

        return result
        
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
  
  struct GlyphSet {
    private let glyphMap: [BoxGlyph: Character]
    
    init(set: String) {
      let glyphs = set.split(separator: " ")
      var map: [BoxGlyph: Character] = [:]
      
      // Assuming the order of glyphs in the set string matches the order in BoxGlyph cases
      map[.horizontal(.exterior)] = glyphs[0].first!
      map[.horizontal(.interior)] = glyphs[1].first!
      map[.vertical(.exterior)] = glyphs[2].first!
      map[.vertical(.interior)] = glyphs[3].first!
      // Add mappings for other glyph types
      
      self.glyphMap = map
    }
    
    func character(for glyph: BoxGlyph) -> Character {
      return glyphMap[glyph] ?? " "
    }
  }
}
