//
//  BoxLine+Text.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

public extension SwiftBox {
  
  struct TextContent: LineContent {
    public let rawContent: String
    public let type: LineType = .text
    public let lineLimit: Int
    
    init(_ text: String, lineLimit: Int = 0) {
      self.rawContent = text
      self.lineLimit = lineLimit
    }
  }
  
}
