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
  
  struct BoxLine {
    let content: LineContent
    let boxWidth: Int
    let leadingCap: BoxPart
    let trailingCap: BoxPart
    let theme: SwiftBox.Theme
    
    /// Default initialiser (structure-based)
    ///
    init(
      boxWidth: Int,
      repeater: BoxPart,
      leadingCap: BoxPart,
      trailingCap: BoxPart,
      theme: SwiftBox.Theme
    ) {
      self.boxWidth = boxWidth
      
      
      let shadowWidth: Int = theme.shadow.reservedSpace
      let capWidth: Int = leadingCap.width + trailingCap.width

      let reservedWidth = capWidth + shadowWidth
      let remainingWidth = max(0, (boxWidth - reservedWidth))
      
      self.content = StructuralContent(adjustedWidth: remainingWidth, repeatingPattern: repeater)
      self.leadingCap = leadingCap
      self.trailingCap = trailingCap
      self.theme = theme
    }
    
    /// Convenience initialiser for text-based content
    ///
    init(
      text: String,
      lineLimit: Int,
      boxWidth: Int,
      theme: SwiftBox.Theme
    ) {
      
      self.content = TextContent(text, lineLimit: lineLimit)
      self.boxWidth = boxWidth
      self.theme = theme
      
      /// Currently, this initialiser 'has to' take in a `theme` parameter, to obtain
      /// the correct `BoxParts` for the leading and trailing caps, to save
      /// the package user from having to do it. Text-based lines will always
      /// have the below part types (obviously with the correct glyphs subbed
      /// in based on the selected Theme).
      ///
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

public extension SwiftBox.BoxLine {
  
  protocol LineContent {
    var rawContent: String { get }
  }

  typealias ThreePartLine = (
    leading: SwiftBox.PartType,
    repeater: SwiftBox.PartType,
    trailing: SwiftBox.PartType
  )
  
  /// What kinds of lines could there be, in a box?
  ///
  /// Note: These, by definition, describe a *whole* line, stretching
  /// from one end to the other. Not just a sub-component.
  ///
  /// E.g. `top` would consist of a leading cap, repeating part, and trailing cap.
  ///
  enum LinePreset: Hashable {
    case top
    case divider
    case bottom
    case text(content: String, lineLimit: Int = 0)
    
    public var parts: ThreePartLine? {
      switch self {
        case .top:
          (
            SwiftBox.PartType.cornerTopLeading,
            SwiftBox.PartType.horizontal(.top),
            SwiftBox.PartType.cornerTopTrailing
          )
        case .divider:
          (
            SwiftBox.PartType.joinLeading,
            SwiftBox.PartType.horizontal(.interior),
            SwiftBox.PartType.joinTrailing
          )
        case .bottom:
          (
            SwiftBox.PartType.cornerBottomLeading,
            SwiftBox.PartType.horizontal(.bottom),
            SwiftBox.PartType.cornerBottomTrailing
          )
        case .text:
          nil
      }
    } // END parts
    
    private static let shadowLookup: [LinePreset: Set<SwiftBox.LightSource>] = [
      .top: [.bottomLeading, .bottomTrailing],
      .bottom: [.topLeading, .topTrailing]
    ]
    
    func hasShadow(lightSource: SwiftBox.LightSource) -> Bool {
      switch self {
        case .top, .bottom:
          return Self.shadowLookup[self, default: []].contains(lightSource)
        case .divider, .text:
          return false
      }
    }
  }
  
}

