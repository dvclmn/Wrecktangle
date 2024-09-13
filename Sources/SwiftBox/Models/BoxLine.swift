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
    init(text: String, lineLimit: Int, theme: SwiftBox.Theme) {
      
      self.content = TextContent(text, lineLimit: lineLimit)
      self.leadingCap = BoxPart.create(.vertical(.leading), theme: theme)
      self.trailingCap = BoxPart.create(.vertical(.trailing), theme: theme)
      
      let conditions = Self.checkConditions(leadingCap: self.leadingCap, trailingCap: self.trailingCap)
      
      precondition(
        conditions.condition,
        conditions.message
      )
      
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
    case text(content: String, lineLimit: Int = 0)
    case shadow
    
    public var parts: (
      leading: PartType,
      repeater: PartType,
      trailing: PartType
    )? {
      switch self {
        case .top:
          (
            PartType.cornerTopLeading,
            PartType.horizontal(.top),
            PartType.cornerTopTrailing
          )
        case .divider:
          (
            PartType.joinLeading,
            PartType.horizontal(.interior),
            PartType.joinTrailing
          )
        case .bottom:
          (
            PartType.cornerBottomLeading,
            PartType.horizontal(.bottom),
            PartType.cornerBottomTrailing
          )
        case .text, .shadow:
          nil
      }
    }
  }
  
}

