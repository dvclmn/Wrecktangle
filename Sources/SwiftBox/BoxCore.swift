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
    
    /// 1. Create top-most line — the roof of the box
    ///
    output += widthCounter(self.config.width)
    output += self.processBoxLine(type: .top)
    output.addNewLine()
    
    let headerLines: [String] = self.header.reflowText(width: width, maxLines: config.headerLineLimit)
    let contentLines: [String] = self.content.reflowText(width: width, maxLines: config.contentLineLimit)
    
    for line in headerLines {
      output += self.processBoxLine(line, type: .header)
      output.addNewLine()
    }
    
    output += self.processBoxLine(type: .divider)
    output += AttributedString("\n")
    
    for line in contentLines {
      output += self.processBoxLine(line, type: .content)
      output += AttributedString("\n")
    }
    
    output += self.processBoxLine(type: .bottom)
    
    return output
  }
  
  /// From the top down, what are the line types that can be generated?
  ///
  /// - top line
  /// - header lines
  /// - divider
  /// - content lines
  /// - bottom line
  ///
  func processBoxLine(_ reflowedLine: String? = nil, type: Line) -> AttributedString {
    
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
        capLeading = Part.vertical(location: .exterior)
        capTrailing = Part.vertical(location: .exterior)
        
      case .divider:
        capLeading = Part.vertical(join: .leading, location: .exterior)
        capTrailing = Part.vertical(join: .trailing, location: .exterior)
        
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
      output += repeatingPart(for: type)
    }
    
    
    return output
  }

  
  private func repeatingPart(for line: Line) -> AttributedString {
    
    var output = AttributedString("")
    
    let repeatCount: Int = self.config.width - (Self.paddingSize - 2)
    
    switch line {
      case .top, .bottom:
        let part = Part.horizontal(location: .exterior).character(with: config).asString
        output += AttributedString(String(repeating: part, count: repeatCount))
        
      case .header, .content:
        break // header and content should produce actual text content, not a structural Part
        
      case .divider:
        let part = Part.horizontal(location: .interior).character(with: config).asString
        output += AttributedString(String(repeating: part, count: repeatCount))
    }
    
    output.setAttributes(container(for: .secondary))
    return output
  }
  
  enum WidthCounterDisplayStyle {
    case full
    case compact
  }
  
  func widthCounter(
    _ width: Int,
    style: WidthCounterDisplayStyle = .compact
  ) -> AttributedString {
    
    var result = AttributedString("")
    let adjustedWidth = width + 1 // To make up for starting from 1
    
    switch style {
      case .full:
        // First line: 10's (with leading zero)
        var tensLine = ""
        for i in 1..<adjustedWidth {
          tensLine += String((i / 10) % 10)
        }
        result.appendString(tensLine)
        result.addNewLine()
        
        // Second line: counting up by one
        var onesLine = ""
        for i in 1..<adjustedWidth {
          onesLine += String(i % 10)
        }
        result.appendString(onesLine)
        result.addNewLine()
        
      case .compact:
        var compactLine = "1"
        var i = 5
        while i <= width {
          let spaces = String(repeating: " ", count: i <= 9 ? 4 : 3)
          if i % 10 == 5 {
            compactLine += spaces + "· "
          } else {
            // Align two-digit numbers with the first digit over the marker
            if i >= 10 {
              compactLine += String(repeating: " ", count: 3) + String(i)
            } else {
              compactLine += spaces + String(i)
            }
          }
          i += 5
        }
        
        // Handle the final number
        if width % 5 != 0 {
          let lastNumberString = String(width)
          let spacesNeeded = width - compactLine.count - lastNumberString.count
          if spacesNeeded > 0 {
            compactLine += String(repeating: " ", count: spacesNeeded) + lastNumberString
          } else {
            // If we've overshot, trim the line and add the last number
            compactLine = String(compactLine.prefix(width - lastNumberString.count)) + lastNumberString
          }
        }
        result.appendString(compactLine)
        result.addNewLine()
        result.appendString(
          String.repeating(
            ".",
            alternating: "|",
            every: 5,
            totalCount: width
          )
        )
        result.addNewLine()
    }
    
    
    result.setAttributes(container(for: .tertiary))
    return result
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
