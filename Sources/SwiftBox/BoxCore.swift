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
    
    /// Starting the count at 3 for the box roof, divider and floor
    var lineCount: Int = self.config.extraFrame ? 7 : 3
    
    /// Width counter
    if self.config.metrics.widthCounter != .off {
      output += widthCounter(self.config.width)
    }
    
    /// Box roof
    output += self.constructBoxLine(type: .top)
    
    /// Header
    
    let headerWidth: Int = self.config.width - calculateReservedHorizontalSpace(for: .header)
    let headerLines: [String] = self.header.reflowText(width: headerWidth, maxLines: config.headerLineLimit)
    for line in headerLines {
      lineCount += 1
      output += self.constructBoxLine(line, type: .header)
    }
    
    /// Divider
    output += self.constructBoxLine(type: .divider)
    
    /// Content
    let contentWidth: Int = self.config.width - calculateReservedHorizontalSpace(for: .content)
    let contentLines: [String] = self.content.reflowText(width: contentWidth, maxLines: config.contentLineLimit)
    var contentLineCount: Int = 0
    for line in contentLines {
      lineCount += 1
      contentLineCount += 1
      output += self.constructBoxLine(line, type: .content, lineCount: contentLineCount)
    }
    
    /// This could be made conditional on whether the theme's `GlyphSet`
    /// requires it, but this ensures that if there's an alternating frame part,
    /// the number of lines won't create alignment/joining issues
    ///
//    if !lineCount.isEven {
//      output += self.constructBoxLine(" ", type: .content)
//    }
    
    /// Box floor
    output += self.constructBoxLine(type: .bottom)
    
    return output
  }
  
  
  /// Width set aside for leading and trailing box parts and spaces
  /// and adjusted to compensate for the extra frame option
  ///
  func calculateReservedHorizontalSpace(for type: Line) -> Int {
    
    var reserved: Int = 4
    
    /// The header doesn't need to account for line numbers
    ///
    switch type {
      case .header:
        if self.config.extraFrame {
          reserved += 4
        }
        
      case .content:
        if self.config.extraFrame {
          reserved += 4
        }
        if self.config.metrics.lineNumbers {
          reserved += 4
        }
      default: break
    }
    
    return reserved
  }
  
  /// Builds a single line. `reflowedLine` is optional — some lines
  /// will be comprised of text, and some of repeated frame parts
  func constructBoxLine(
    _ reflowedLine: String? = nil,
    type: Line,
    lineCount: Int? = nil
  ) -> AttributedString {
    
    var output = AttributedString()
    
    if let text = reflowedLine {
      
      /// Set up leading cap
      ///
      output += type.cap(.leading, with: config)
      
      /// Leading space
      ///
      output.appendString(" ")
      
      /// Line numbers
      ///
      
      if self.config.metrics.lineNumbers, let lineCount = lineCount, type == .content {
        
        if lineCount <= 9 {
          output.appendString(" ")
        }
        output.appendString(lineCount.description)
        output.appendString("  ")
      }
      
      
      /// Add the reflowed text
      ///
      /// Note: Using `+=` on two `AttributedString`s will keep the attributes
      /// for each, provided... something. Can't remember. Will need to keep an eye
      /// on this and try to remember how it works.
      ///
      let reflowedString = AttributedString(text, attributes: container(for: .primary))
      output += reflowedString
      
      /// Set up padding characters, to fill out to the end of the box, so the trailing wall is aligned nicely
      ///
      let paddingCharacter = self.config.metrics.invisibles ? Invisibles.padding.character : " "
      
      let totalWidth = self.config.width - calculateReservedHorizontalSpace(for: type)
      let paddingNeeded = max(0, totalWidth - text.count)
      
      var paddingString = AttributedString(String(repeating: paddingCharacter, count: paddingNeeded))
      paddingString.mergeAttributes(container(for: .tertiary))
      
      /// Add this padding to the output string
      ///
      output += paddingString
      
      /// Add trailing space
      output.appendString(" ")
      
      /// Trailing cap
      output += type.cap(.trailing, with: config)
      
      /// And ensure that the line breaks, ready for the next one
      output.addLineBreak()
      
    } else {
      
      if self.config.extraFrame {
        
        output += type.cap(.leading, with: config)
        output += repeatingPart(for: type)
        output.addLineBreak()
        output += repeatingPart(for: type)
        output += type.cap(.trailing, with: config)
        output.addLineBreak()
        
      } else {
        
        output += type.cap(.leading, with: config)
        output += repeatingPart(for: type)
        output += type.cap(.trailing, with: config)
        output.addLineBreak()
        
      }
    }
    
    return output
  }
  
  
  /// This function should *only* return the repeating part, no caps
  ///
  private func repeatingPart(for line: Line) -> AttributedString {
    
    var output = AttributedString()
    let partToRepeat = line.repeatableString(for: config)
    /// Width set aside for the leading and trailing caps
    
    let reservedSpace: Int = self.config.extraFrame ? 4 : 2
    let repeatCount: Int = self.config.width - reservedSpace
    
    output += AttributedString(String(repeating: partToRepeat, count: repeatCount))
    
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
