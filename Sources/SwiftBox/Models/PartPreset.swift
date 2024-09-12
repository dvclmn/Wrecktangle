//
//  Part+Corner.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//

public extension SwiftBox {
  
  struct BoxPart {
    public var content: CharacterGrid
    public var resolution: Resolution
    
    public init(
      content: CharacterGrid,
      resolution: Resolution
    ) {
      self.resolution = resolution
      
      precondition(
        content.rows == resolution.rows
        && content.columns == resolution.columns,
        "Content grid size must match resolution"
      )
      
      self.content = content
    }

  }

}

extension SwiftBox.BoxPart: CustomStringConvertible {
  
  public var description: String {
    let gridDescription = self.content.description
    return """
        Preset(resolution: \(self.resolution))
        \(gridDescription)
        
        """
  }
}
extension SwiftBox.CharacterGrid: CustomStringConvertible {
  public var description: String {
    let rowStrings = (0..<rows).map { row in
      (0..<columns).map { column in
        String(self[row, column])
      }.joined()
    }
    return rowStrings.joined(separator: "\n")
  }
}




