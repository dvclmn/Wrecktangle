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
    
    
    attrString.appendString(horizontalStructure(ofType: lineType), addsLineBreak: false)
    
    attrString.appendString(BoxLine.structure(lineType).cap(.trailing, from: config.theme.glyphSet), addsLineBreak: true)

//    print("Here is the Structural line: \(attrString)")
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
    
    let paddingCount = self.config.theme.padding
    let paddingCharacter = self.config.metrics.invisibles ? Invisibles.space.character : " "
    
    let paddingString = String(repeating: paddingCharacter, count: paddingCount)
    
    attrString.appendString(paddingString, addsLineBreak: false)
    
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
    
    
//    paddingString.mergeAttributes(container(for: .tertiary))
    
    /// Add this padding to the output string
    ///
//    attrString += paddingString
    
    /// Add trailing space
    attrString.appendString(paddingString, addsLineBreak: false)
    
    /// Trailing cap
    attrString.appendString(BoxLine.text(lineType).cap(.trailing, from: config.theme.glyphSet), addsLineBreak: false)
    
    /// And ensure that the line breaks, ready for the next one
    attrString.addLineBreak()
    
    
  }
  
  
  
  
  /// This function should *only* return the repeating part, no caps
  ///
  private func horizontalStructure(ofType structure: BoxLine.Structure) -> String {
    
    /// Structural elements
//    var output = AttributedString()
    
    let partToRepeat = structure.repeatablePart(from: config.theme.glyphSet)
    
    // TODO: The use of `.top` here is arbitrary, as I really only wanted to specify options 'structure or text'. Could use a tidy.
    let output = String(repeating: partToRepeat, count: adjustedBoxWidth(for: .structure(.top)))
    
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
