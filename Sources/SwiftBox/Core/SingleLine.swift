//
//  SingleLine.swift
//  SwiftBox
//
//  Created by Dave Coleman on 24/8/2024.
//

import Foundation

extension SwiftBox {
  
  func buildStructuralLine(
    _ lineType: BoxLine,
    attrString: inout AttributedString
  ) {
    
    //    if self.config.extraFrame {
    //
    //      string += lineType.cap(.leading, with: config)
    //      string += repeatingPart(for: lineType)
    //      string.addLineBreak()
    //      string += repeatingPart(for: lineType)
    //      string += lineType.cap(.trailing, with: config)
    //      string.addLineBreak()
    //
    //    } else {
    
    attrString += lineType.cap(.leading, with: config)
    attrString += repeatingPart(for: lineType)
    attrString.addLineBreak()
    attrString += repeatingPart(for: lineType)
    attrString += lineType.cap(.trailing, with: config)
    attrString.addLineBreak()

    //    }
    
  }
  
  func buildTextLine(
    _ lineType: BoxLine,
    text: String,
    lineCount: Int? = nil,
    attrString: inout AttributedString
  ) {
    
    
    /// Set up leading cap
    ///
    attrString += lineType.cap(.leading, with: config)
    attrString += lineType.cap(.leading, with: config)
    
    /// Leading space
    ///
    attrString.appendString(" ")
    
    /// Line numbers
    ///
    
    if let lineCount = lineCount, self.config.metrics.lineNumbers {
      if lineCount <= 9 {
        attrString.appendString(" ")
      }
      attrString.appendString(lineCount.description)
      attrString.appendString("  ")
      
    }

    /// Add the reflowed text
    ///
    /// Note: Using `+=` on two `AttributedString`s will keep the attributes
    /// for each, provided... something. Can't remember. Will need to keep an eye
    /// on this and try to remember how it works.
    ///
    let reflowedString = AttributedString(text)
//    let reflowedString = AttributedString(text, attributes: container(for: .primary))
    attrString += reflowedString
    
    /// Set up padding characters, to fill out to the end of the box, so the trailing wall is aligned nicely
    ///
    let paddingCharacter = self.config.metrics.invisibles ? Invisibles.padding.character : " "
    
    let totalWidth = self.config.width - calculateReservedHorizontalSpace(for: lineType)
    let paddingNeeded = max(0, totalWidth - text.count)
    
    var paddingString = AttributedString(String(repeating: paddingCharacter, count: paddingNeeded))
//    paddingString.mergeAttributes(container(for: .tertiary))
    
    /// Add this padding to the output string
    ///
    attrString += paddingString
    
    /// Add trailing space
    attrString.appendString(" ")
    
    /// Trailing cap
    attrString += lineType.cap(.trailing, with: config)
    
    /// And ensure that the line breaks, ready for the next one
    attrString.addLineBreak()
    
    
  }
  
  
  
  
  /// This function should *only* return the repeating part, no caps
  ///
  private func repeatingPart(for line: BoxLine) -> AttributedString {
    
    var output = AttributedString()
    let partToRepeat = line.repeatableString(for: config)
    /// Width set aside for the leading and trailing caps
    
    let reservedSpace: Int =  2
//    let reservedSpace: Int = self.config.extraFrame ? 4 : 2
    let repeatCount: Int = self.config.width - reservedSpace
    
    output += AttributedString(String(repeating: partToRepeat, count: repeatCount))
    
//    output.setAttributes(container(for: .secondary))
    return output
  }
  
  
//  func container(for style: ColourSet) -> AttributeContainer {
//    
//    switch style {
//      case .primary:
//        return self.config.theme.colour.primary.container
//      case .secondary:
//        return self.config.theme.colour.secondary.container
//      case .tertiary:
//        return self.config.theme.colour.tertiary.container
//      case .accent:
//        return self.config.theme.colour.accent.container
//    }
//  }
  

  
}
