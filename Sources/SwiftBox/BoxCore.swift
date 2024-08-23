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

  func drawBox() -> AttributedString {
    
    var output = AttributedString()
    
    /// Width set aside for leading and trailing box parts and spaces
    let reservedWidth: Int = 4
    
    let textWidth: Int = self.config.width - reservedWidth
    
    /// Width counter
    output += widthCounter(self.config.width)
    
    /// Box roof
    output += self.constructBoxLine(type: .top)
    output.addNewLine()

    /// Header
    let headerLines: [String] = self.header.reflowText(width: textWidth, maxLines: config.headerLineLimit)
    for line in headerLines {
      output += self.constructBoxLine(line, type: .header)
      output.addNewLine()
    }
    
    /// Divider
    output += self.constructBoxLine(type: .divider)
    output += AttributedString("\n")
    
    /// Content
    let contentLines: [String] = self.content.reflowText(width: textWidth, maxLines: config.contentLineLimit)
    for line in contentLines {
      output += self.constructBoxLine(line, type: .content)
      output += AttributedString("\n")
    }
    
    /// Box floor
    output += self.constructBoxLine(type: .bottom)
    
    return output
  }
  
  func constructBoxLine(_ reflowedLine: String? = nil, type: Line) -> AttributedString {
    
    var output = AttributedString()
    
    if let text = reflowedLine {
      
      /// Set up leading cap
      ///
      output += type.cap(.leading, with: config)
      
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
      output += type.cap(.trailing, with: config)
      
      
    } else {
//      output += capLeading.character(with: self.config)
      output += type.cap(.leading, with: config)
      output += repeatingPart(for: type)
      output += type.cap(.trailing, with: config)
    }
    
    return output
  }

  
  /// This function should *only* return the repeating part, no caps
  ///
  private func repeatingPart(for line: Line) -> AttributedString {
    
    var output = AttributedString()
    
    /// Width set aside for the leading and trailing caps
    let reservedSpace: Int = 2
    let repeatCount: Int = self.config.width - reservedSpace
    
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
