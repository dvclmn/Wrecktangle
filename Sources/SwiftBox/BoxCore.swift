//
//  BoxHandler.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUICore
import BaseHelpers

public extension SwiftBox {
  
  /// This `paddingSize` value compensates for:
  ///
  /// 1. The leading wall character
  /// 2. A leading space
  /// 3  A trailing space
  /// 4. The trailing wall character
  ///
  private static let paddingSize: Int = 4
  
  func drawBox() -> AttributedString {
    
    var output = AttributedString()
    let width: Int = self.config.width - SwiftBox.paddingSize
    
    /// Width counter
    output += widthCounter(self.config.width)
    
    /// Box roof
    output += self.constructBoxLine(type: .top)
    output.addNewLine()
    
    
    let headerLines: [String] = self.header.reflowText(width: width, maxLines: config.headerLineLimit)
    let contentLines: [String] = self.content.reflowText(width: width, maxLines: config.contentLineLimit)
    
    for line in headerLines {
      output += self.constructBoxLine(line, type: .header)
      output.addNewLine()
    }
    
    output += self.constructBoxLine(type: .divider)
    output += AttributedString("\n")
    
    for line in contentLines {
      output += self.constructBoxLine(line, type: .content)
      output += AttributedString("\n")
    }
    
    output += self.constructBoxLine(type: .bottom)
    
    return output
  }
  
  func constructBoxLine(_ reflowedLine: String? = nil, type: Line) -> AttributedString {
    
    var output = AttributedString()
    var capLeading: Part
    var capTrailing: Part
    
    /// Caps (these are not the lines themselves, just the caps)
    ///
    switch type {
      case .top:
        capLeading = Part.corner(.top(.leading))
        capTrailing = Part.corner(.top(.trailing))
        
      case .header, .content:
        capLeading = Part.vertical(.exterior)
        capTrailing = Part.vertical(.exterior)
        
      case .divider:
        capLeading = Part.join(.leading)
        capTrailing = Part.join(.trailing)
        
      case .bottom:
        capLeading = Part.corner(.bottom(.leading))
        capTrailing = Part.corner(.bottom(.trailing))
    }
    
    output = cappedLine(capLeading, reflowedLine, capTrailing, for: type)
    
    return output
  }
  
  private func cappedLine(
    _ capLeading: Part,
    _ text: String?,
    _ capTrailing: Part,
    for type: Line
  ) -> AttributedString {
    
    var output = AttributedString("")
    
    if let text = text {
      
      /// Set up leading cap
      ///
      output += capLeading.character(with: config, container: container(for: .secondary))
      
      /// Leading space
      ///
      output.appendString(" ")
      
      /// Add text to the attr. string
      ///
      output.appendString(text)
      output.mergeAttributes((container(for: .primary)))
      
      /// Set up padding characters, to fill out to the end of the box, so the trailing wall is aligned nicely
      ///
      let paddingCharacter = Invisibles.padding.character
      let totalWidth = self.config.width - 4 // leading cap, leading space, trailing cap
      let paddingNeeded = max(0, totalWidth - text.count)
      
      var paddingString = AttributedString(String(repeating: paddingCharacter, count: paddingNeeded))
      paddingString.mergeAttributes(container(for: .tertiary))
      
      /// Add this padding to the output string
      ///
      output += paddingString
      
      output.appendString(" ")
      output += capTrailing.character(with: config, container: container(for: .secondary))
      
      
    } else {
      output += capLeading.character(with: self.config)
      output += repeatingPart(for: type)
    }
    
    
    return output
  }

  /// This function should *only* return the repeating part, no caps
  ///
  private func repeatingPart(for line: Line) -> AttributedString {
    
    var output = AttributedString()
    
    let repeatCount: Int = self.config.width - (Self.paddingSize - 2)
    
    switch line {
      case .top:
        let partToRepeat = Part.horizontal(.exterior).character(with: config).asString
        output += AttributedString(String(repeating: partToRepeat, count: repeatCount))
        
      case .header, .content:
        /// header and content consist of actual text content, and don't require a repeating part
        break
        
      case .divider:
        let partToRepeat = Part.horizontal(.interior).character(with: config).asString
        output += AttributedString(String(repeating: partToRepeat, count: repeatCount))
        
      case .bottom:
        let partToRepeat = Part.horizontal(.exterior).character(with: config).asString
        output += AttributedString(String(repeating: partToRepeat, count: repeatCount))
    }
    
    output.setAttributes(container(for: .secondary))
    return output
  }
  
  
  func container(for style: GlyphStyle.StyleType) -> AttributeContainer {
    
    switch style {
      case .primary:
        return self.config.theme.styles.primary.container
      case .secondary:
        return self.config.theme.styles.secondary.container
      case .tertiary:
        return self.config.theme.styles.tertiary.container
      case .accent:
        return self.config.theme.styles.accent.container
    }
  }
  
  
  
}
