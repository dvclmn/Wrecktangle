//
//  Part+Corner.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//

import TextCore
import Foundation

public extension SwiftBox {
  
  struct BoxPart {
    public var content: CharacterGrid
    public var type: PartType
    
    public init(
      content: CharacterGrid,
      type: PartType
    ) {
      
//      precondition(
//        content.rows == self.resolution.rows
//        && content.columns == resolution.columns,
//        """
//        Content grid size must match resolution.
//        Grid Columns: \(content.columns), Rows: \(content.rows)
//        Resolution: \(resolution.columns)x\(resolution.rows)
//        """
//      )
//      
      self.content = content
      self.type = type
    }
    
    
  }
  

  enum PartType: Hashable {
    
    case horizontal(location: HorizontalLocation = .top)
    case vertical(location: VerticalLocation = .leading)
    
    case joinLeading            /// ┠
    case joinTrailing           /// ┨
    case joinTop                /// ┯
    case joinBottom             /// ┷
    case joinCross              /// ┼
    
    case cornerTopLeading       /// ┏
    case cornerTopTrailing      /// ┓
    case cornerBottomLeading    /// ┗
    case cornerBottomTrailing   /// ┛
    
    public enum HorizontalLocation: Hashable {
      case top
      case bottom
      case interior // Divider
    }
    
    public enum VerticalLocation: Hashable {
      case leading
      case trailing
      case interior // Divider
    }
    

    
  }
  
}

public extension SwiftBox.BoxPart {
  
  var output: String {
    
    let rows = self.content.rows
    let columns = self.content.columns
    
    let rowStrings = (0..<rows).map { row in
      (0..<columns).map { column in
        String(self.content[column, row])
      }.joined()
    }
    
    let result = rowStrings.joined(separator: "\n")
    
    return result
  }
  
  
  
  var multiRowString: SwiftBox.MultiRowString {
      let rows = (0..<content.rows).map { row in
        String((0..<content.columns).map { column in
          content[column, row]
        })
      }
    return SwiftBox.MultiRowString(rows)
    }

}


extension SwiftBox.BoxPart {
  var multiLineAttributedString: MultiLineAttributedString {
    var result = MultiLineAttributedString()
    for row in 0..<content.rows {
      var lineString = AttributedString()
      for column in 0..<content.columns {
        lineString += AttributedString(String(content[column, row]))
      }
      result.appendLine(lineString)
    }
    return result
  }
}



public extension SwiftBox {
  
  struct MultiRowString {
    var rows: [String]
    
    init(_ rows: [String]) {
      self.rows = rows
    }
    
    static func +(lhs: MultiRowString, rhs: MultiRowString) -> MultiRowString {
      let maxRows = max(lhs.rows.count, rhs.rows.count)
      var result: [String] = []
      
      for i in 0..<maxRows {
        let leftRow = i < lhs.rows.count ? lhs.rows[i] : String(repeating: " ", count: lhs.rows.first?.count ?? 0)
        let rightRow = i < rhs.rows.count ? rhs.rows[i] : String(repeating: " ", count: rhs.rows.first?.count ?? 0)
        result.append(leftRow + rightRow)
      }
      
      return MultiRowString(result)
    }
    
    func repeated(_ count: Int) -> MultiRowString {
      let repeatedRows = rows.map { row in
        String(repeating: row, count: count)
      }
      return MultiRowString(repeatedRows)
    }
    
    var description: String {
      return rows.joined(separator: "\n")
    }
  }
  
  
  
}


//extension SwiftBox.BoxPart: CustomStringConvertible {
//  
//  public var description: String {
//    let gridDescription = self.content.description
//    return """
//        Preset(resolution: \(self.resolution))
//        \(gridDescription)
//        
//        """
//  }
//}
//extension SwiftBox.CharacterGrid: CustomStringConvertible {
//  public var description: String {
//    let rowStrings = (0..<rows).map { row in
//      (0..<columns).map { column in
//        String(self[row, column])
//      }.joined()
//    }
//    return rowStrings.joined(separator: "\n")
//  }
//}




