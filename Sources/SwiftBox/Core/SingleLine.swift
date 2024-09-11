//
//  SingleLine.swift
//  SwiftBox
//
//  Created by Dave Coleman on 24/8/2024.
//

import Foundation

public extension SwiftBox {
  
  func buildLine(
    type: BoxLine,
    string: String?,
    attrString: inout AttributedString
  ) {
    
    switch type {
      case .structure(let lineType):
        
        buildStructuralLine(lineType, attrString: &attrString)
        
      case .text(let lineType):
        
        if let string = string {
          buildTextLine(lineType, text: string, attrString: &attrString)
        }
      
    }
    
  }

  func buildStructuralLine(
    _ lineType: BoxLine.Structure,
    attrString: inout AttributedString
  ) {
    
    /// 1. Leading cap
    attrString.appendString(BoxLine.structure(lineType).cap(.leading, from: config.theme.glyphSet), addsLineBreak: false)
    
    //    if self.config.extraFrame {
    //
    //      string += lineType.cap(.leading, with: config)
    //      string += horizontalStructure(for: lineType)
    //      string.addLineBreak()
    //      string += horizontalStructure(for: lineType)
    //      string += lineType.cap(.trailing, with: config)
    //      string.addLineBreak()
    //
    //    } else {
    
    
    attrString.appendString(horizontalStructure(ofType: lineType), addsLineBreak: true)
    

//    attrString.addLineBreak()
//    attrString += horizontalStructure(for: lineType)
//    attrString += lineType.cap(.trailing, with: config)
//    attrString.addLineBreak()

    //    }
    
  }
  
  func buildTextLine(
    _ lineType: BoxLine.Text,
    text: String,
    /// Line number support coming later
//    lineCount: Int? = nil,
    attrString: inout AttributedString
  ) {
    
    
    /// Set up leading cap
    ///
    attrString.appendString(BoxLine.text(lineType).cap(.leading, from: config.theme.glyphSet), addsLineBreak: false)
//    attrString.appendString(lineType.cap(.leading, from: config.theme.glyphSet))
    
    /// Leading space
    ///
    attrString.appendString(" ", addsLineBreak: false)
    
    /// Line numbers
    ///
    
//    if let lineCount = lineCount, self.config.metrics.lineNumbers {
//      if lineCount <= 9 {
//        attrString.appendString(" ")
//      }
//      attrString.appendString(lineCount.description)
//      attrString.appendString("  ")
//      
//    }

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
    
    let reservedSpace: Int = 10
    
    let totalWidth = self.config.width - reservedSpace
//    let totalWidth = self.config.width - calculateReservedHorizontalSpace(for: lineType)
    let paddingNeeded = max(0, totalWidth - text.count)
    
    var paddingString = AttributedString(String(repeating: paddingCharacter, count: paddingNeeded))
//    paddingString.mergeAttributes(container(for: .tertiary))
    
    /// Add this padding to the output string
    ///
    attrString += paddingString
    
    /// Add trailing space
    attrString.appendString(" ", addsLineBreak: false)
    
    /// Trailing cap
    attrString.appendString(BoxLine.text(lineType).cap(.trailing, from: config.theme.glyphSet), addsLineBreak: false)
    
    /// And ensure that the line breaks, ready for the next one
    attrString.addLineBreak()
    
    
  }
  
  
  
  
  /// This function should *only* return the repeating part, no caps
  ///
  private func horizontalStructure(ofType structure: BoxLine.Structure) -> String {
    
//    var output = AttributedString()
    
    let partToRepeat = structure.repeatablePart(from: config.theme.glyphSet)
    
    
    
    /// Width set aside for the leading and trailing caps
    
    let output = String(repeating: partToRepeat, count: contentWidth)
    
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
