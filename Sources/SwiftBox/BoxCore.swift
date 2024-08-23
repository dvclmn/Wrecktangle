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
//    output += self.constructBoxLine(lineType: .top)
    
    self.buildStructuralLine(.top, string: &output)
    
    /// Header
    
    let headerWidth: Int = self.config.width - calculateReservedHorizontalSpace(for: .header)
    let headerLines: [String] = self.header.reflowText(width: headerWidth, maxLines: config.headerLineLimit)
    for line in headerLines {
      lineCount += 1
      self.buildTextLine(.header, text: line, string: &output)
//      output += self.constructBoxLine(line, lineType: .header)
    }
    
    /// Divider
    self.buildStructuralLine(.divider, string: &output)
//    output += self.constructBoxLine(lineType: .divider)
    
    /// Content
    let contentWidth: Int = self.config.width - calculateReservedHorizontalSpace(for: .content)
    let contentLines: [String] = self.content.reflowText(width: contentWidth, maxLines: config.contentLineLimit)
    var contentLineCount: Int = 0
    for line in contentLines {
      lineCount += 1
      contentLineCount += 1
      self.buildTextLine(.content, text: line, string: &output)
//      output += self.constructBoxLine(line, lineType: .content, lineCount: contentLineCount)
    }
    
    /// This could be made conditional on whether the theme's `GlyphSet`
    /// requires it, but this ensures that if there's an alternating frame part,
    /// the number of lines won't create alignment/joining issues
    ///
//    if !lineCount.isEven {
//      output += self.constructBoxLine(" ", lineType: .content)
//    }
    
    /// Box floor
    self.buildStructuralLine(.bottom, string: &output)
//    output += self.constructBoxLine(lineType: .bottom)
    
    return output
  }
  
  
  /// Width set aside for leading and trailing box parts and spaces
  /// and adjusted to compensate for the extra frame option
  ///
  func calculateReservedHorizontalSpace(for lineType: Line) -> Int {
    
    var reserved: Int = 4
    
    /// The header doesn't need to account for line numbers
    ///
    switch lineType {
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
//  func constructBoxLine(
//    _ reflowedLine: String,
//    lineType: Line,
//    lineCount: Int? = nil
//  ) -> AttributedString {
//    
//    var output = AttributedString()
//    
//    switch lineType {
//      case .top:
//        buildStructuralLine(lineType, string: &output)
//        
//      case .header:
//        
//        
//        
//      case .divider:
//        buildStructuralLine(lineType, string: &output)
//        
//      case .content:
//        
//        buildTextLine(.header, text: reflowedLine, lineCount: lineCount, string: &output)
//        
//      case .bottom:
//        
//        buildStructuralLine(lineType, string: &output)
//    }
//
//    return output
//  }
  
  // TODO: Oh boy, rename/refactor this
  func buildStructuralLine(_ lineType: Line, string: inout AttributedString) {
    
    if self.config.extraFrame {
      
      string += lineType.cap(.leading, with: config)
      string += repeatingPart(for: lineType)
      string.addLineBreak()
      string += repeatingPart(for: lineType)
      string += lineType.cap(.trailing, with: config)
      string.addLineBreak()
      
    } else {
      
      string += lineType.cap(.leading, with: config)
      string += repeatingPart(for: lineType)
      string += lineType.cap(.trailing, with: config)
      string.addLineBreak()
      
    }
    
  }
  
  func buildTextLine(
    _ lineType: Line,
    text: String,
    lineCount: Int? = nil,
    string: inout AttributedString
  ) {
    
      
      /// Set up leading cap
      ///
      string += lineType.cap(.leading, with: config)
      string += lineType.cap(.leading, with: config)
      
      /// Leading space
      ///
      string.appendString(" ")
      
      /// Line numbers
      ///
      
      if self.config.metrics.lineNumbers, let lineCount = lineCount, lineType == .content {
        
        if lineCount <= 9 {
          string.appendString(" ")
        }
        string.appendString(lineCount.description)
        string.appendString("  ")
      }
      
      
      /// Add the reflowed text
      ///
      /// Note: Using `+=` on two `AttributedString`s will keep the attributes
      /// for each, provided... something. Can't remember. Will need to keep an eye
      /// on this and try to remember how it works.
      ///
      let reflowedString = AttributedString(text, attributes: container(for: .primary))
      string += reflowedString
      
      /// Set up padding characters, to fill out to the end of the box, so the trailing wall is aligned nicely
      ///
      let paddingCharacter = self.config.metrics.invisibles ? Invisibles.padding.character : " "
      
      let totalWidth = self.config.width - calculateReservedHorizontalSpace(for: lineType)
      let paddingNeeded = max(0, totalWidth - text.count)
      
      var paddingString = AttributedString(String(repeating: paddingCharacter, count: paddingNeeded))
      paddingString.mergeAttributes(container(for: .tertiary))
      
      /// Add this padding to the output string
      ///
      string += paddingString
      
      /// Add trailing space
      string.appendString(" ")
      
      /// Trailing cap
      string += lineType.cap(.trailing, with: config)
      
      /// And ensure that the line breaks, ready for the next one
      string.addLineBreak()
    
    
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
