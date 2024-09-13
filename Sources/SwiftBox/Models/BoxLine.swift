//
//  Line.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//


/// Currently this library can only handle horizontal dividers, not vertical.
/// So processing line-by-line, vertically, is fairly strightforward.
///




public extension SwiftBox {
  
  protocol LineContent {
    var rawContent: String { get }
    var type: LineType { get }
  }
  
  
  struct StructuralContent: LineContent {
    public let rawContent: String
    public let type: LineType = .structural
    let repeatingCharacter: Character
    
    init(repeatingCharacter: Character) {
      self.repeatingCharacter = repeatingCharacter
      self.rawContent = String(repeatingCharacter)
    }
  }
  
  struct TextContent: LineContent {
    public let rawContent: String
    public let type: LineType = .text
    
    init(_ text: String) {
      self.rawContent = text
    }
  }
  
  
  
  
  struct BoxLine {
    let content: LineContent
    let leadingCap: BoxPart
    let trailingCap: BoxPart
    
    init(content: LineContent, leadingCap: BoxPart, trailingCap: BoxPart) {
      self.content = content
      self.leadingCap = leadingCap
      self.trailingCap = trailingCap
    }
    
    func render(width: Int) -> String {
      
      let contentWidth = width - leadingCap.width - trailingCap.width
      let renderedContent: String
      
      switch content.type {
        case .structural:
          if let structuralContent = content as? StructuralContent {
            renderedContent = String(repeating: structuralContent.repeatingCharacter, count: contentWidth)
          } else {
            renderedContent = String(repeating: " ", count: contentWidth)
          }
        case .text:
          renderedContent = content.rawContent.padding(toLength: contentWidth, withPad: " ", startingAt: 0)
      }
      
      return leadingCap.render() + renderedContent + trailingCap.render()
    }
  }
}

public extension SwiftBox {
  
  enum LineType {
    case structural
    case text
  }
  
}
