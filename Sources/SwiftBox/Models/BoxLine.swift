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
  }
  
}

public extension SwiftBox {
  
  func line(
    _ preset: LinePreset
  ) -> String {
    
    let leading: BoxPart?
    let repeater: BoxPart?
    let trailing: BoxPart?
    let textContent: String?
    let textLineLimit: Int?

    switch preset {
      case .top:
        leading = BoxPart.create(.cornerTopLeading, theme: theme)
        repeater = BoxPart.create(.horizontal(.top), theme: theme)
        trailing = BoxPart.create(.cornerTopTrailing, theme: theme)
        textContent = nil
        textLineLimit = nil
        
      case .divider:
        leading = BoxPart.create(.joinLeading, theme: theme)
        repeater = BoxPart.create(.horizontal(.interior), theme: theme)
        trailing = BoxPart.create(.joinTrailing, theme: theme)
        textContent = nil
        textLineLimit = nil
        
      case .bottom:
        leading = BoxPart.create(.cornerBottomLeading, theme: theme)
        repeater = BoxPart.create(.horizontal(.bottom), theme: theme)
        trailing = BoxPart.create(.cornerBottomTrailing, theme: theme)
        textContent = nil
        textLineLimit = nil
        
      case let .text(content, lineLimit):
        leading = nil
        repeater = nil
        trailing = nil
        
        let textPadding = String(repeating: invisibleIfNeeded(.space), count: theme.padding)
        
        textContent = textPadding + content + textPadding
        textLineLimit = lineLimit
        
    } // END switch line preset
    
    let lineResult: SwiftBox.BoxLine
    
    if let text = textContent, let lineLimit = textLineLimit {
      lineResult = SwiftBox.BoxLine(text: text, lineLimit: lineLimit, theme: theme)
      
    } else if let leading = leading, let repeater = repeater, let trailing = trailing {
      lineResult = BoxLine(repeater: repeater, leadingCap: leading, trailingCap: trailing)
    } else {
      fatalError("The above *should* be supplying this function with what it needs.")
    }
    
    let result = lineResult.render(width: boxWidth)
    
    return result
    
  } // END create line
  
}
