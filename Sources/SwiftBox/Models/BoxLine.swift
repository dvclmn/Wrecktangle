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
    let repeatingPattern: BoxPart
    
    init(repeatingPattern: BoxPart) {
      self.repeatingPattern = repeatingPattern
      self.rawContent = repeatingPattern.content.map { String($0) }.joined(separator: "\n")
    }
    
    func render(width: Int, trimMethod: TrimMethod = .leaveSpace) -> [[Character]] {
      return SwiftBox.repeatHorizontally(repeatingPattern, toWidth: width, trimMethod: trimMethod)
    }
  }

  
  struct TextContent: LineContent {
    public let rawContent: String
    public let type: LineType = .text
    public let lineLimit: Int
    
    init(_ text: String, lineLimit: Int = 0) {
      self.rawContent = text
      self.lineLimit = lineLimit
    }
  }

  struct BoxLine {
    let content: LineContent
    let leadingCap: BoxPart
    let trailingCap: BoxPart
    
    /// Default initialiser
    ///
    init(
      repeater: BoxPart,
      leadingCap: BoxPart,
      trailingCap: BoxPart
    ) {
      self.content = StructuralContent(repeatingPattern: repeater)
      self.leadingCap = leadingCap
      self.trailingCap = trailingCap
      
      
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
    
    
    
    func render(width: Int, trimMethod: TrimMethod = .leaveSpace) -> String {
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
      
      let outputLines: [String] = renderedContent.enumerated().map { index, row in
        let leadingCapRow = index < leadingCap.content.count ? leadingCap.content[index] : [Character](repeating: " ", count: leadingCap.width)
        let trailingCapRow = index < trailingCap.content.count ? trailingCap.content[index] : [Character](repeating: " ", count: trailingCap.width)
        
        return String(leadingCapRow + row + trailingCapRow)
      }
      
      return outputLines.joined(separator: "\n")
    }
  }
}

public extension SwiftBox {
  
  enum LineType {
    case structural
    case text
    
  }
  
  /// What kinds of lines could there be, in a box?
  ///
  /// Note: These, by definition, describe a *whole* line, stretching
  /// from one end to the other. Not just a sub-component.
  ///
  /// E.g. `top` would consist of a leading cap, repeating part, and trailing cap.
  ///
  enum LinePreset {
    case top
    case divider
    case bottom
  }
  
}



