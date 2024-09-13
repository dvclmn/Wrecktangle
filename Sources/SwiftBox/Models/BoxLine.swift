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
    let repeatingPattern: CharacterGrid
    
    init(repeatingPattern: CharacterGrid) {
      self.repeatingPattern = repeatingPattern
      self.rawContent = repeatingPattern.map { String($0) }.joined(separator: "\n")
    }
    
    func render(width: Int, trimMethod: TrimMethod = .leaveSpace) -> [[Character]] {
      return SwiftBox.repeatHorizontally(repeatingPattern, toWidth: width, trimMethod: trimMethod)
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
    
    /// Default initialiser
    ///
    init(
      content: LineContent,
      leadingCap: BoxPart,
      trailingCap: BoxPart
    ) {
      self.content = content
      self.leadingCap = leadingCap
      self.trailingCap = trailingCap
      
      if content.type == .text {
        let conditions = Self.checkConditions(leadingCap: leadingCap, trailingCap: trailingCap)
        
        precondition(
          conditions.condition,
          conditions.message
        )
      }
      
      
    }
    
    /// Convenience initialiser for text-based content
    ///
    init(text: String, leadingCap: BoxPart, trailingCap: BoxPart) {
      
      let conditions = Self.checkConditions(leadingCap: leadingCap, trailingCap: trailingCap)
      
      precondition(
        conditions.condition,
        conditions.message
      )
      self.content = TextContent(text)
      self.leadingCap = leadingCap
      self.trailingCap = trailingCap
    }
    
    
    
    func render(width: Int, trimMethod: TrimMethod = .leaveSpace) -> [String] {
      let contentWidth = width - leadingCap.width - trailingCap.width
      let renderedContent: [[Character]]
      
      switch content {
        case let structuralContent as StructuralContent:
          renderedContent = structuralContent.render(width: contentWidth, trimMethod: trimMethod)
        case let textContent as TextContent:
          renderedContent = [Array(textContent.rawContent.padding(toLength: contentWidth, withPad: " ", startingAt: 0))]
        default:
          renderedContent = [[Character]](repeating: [Character](repeating: " ", count: contentWidth), count: 1)
      }
      
      return renderedContent.enumerated().map { index, row in
        let leadingCapRow = index < leadingCap.content.count ? leadingCap.content[index] : [Character](repeating: " ", count: leadingCap.width)
        let trailingCapRow = index < trailingCap.content.count ? trailingCap.content[index] : [Character](repeating: " ", count: trailingCap.width)
        
        return String(leadingCapRow + row + trailingCapRow)
      }
    }
  }
}

public extension SwiftBox {
  
  enum LineType {
    case structural
    case text
  }
  
}
