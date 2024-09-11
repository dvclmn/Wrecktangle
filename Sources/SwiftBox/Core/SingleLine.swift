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
    theme: Theme,
    attrString: inout AttributedString
  ) {
    
    switch type {
      case .structure(let lineType):
        
        buildStructuralLine(
          lineType,
          theme: theme,
          attrString: &attrString
        )
        
      case .text(let lineType):
        
        if let string = string {
          buildTextLine(
            lineType,
            text: string,
            theme: theme,
            attrString: &attrString
          )
        }
      
    }
    
  }

  func buildStructuralLine(
    _ lineType: BoxLine.Structure,
    theme: Theme,
    attrString: inout AttributedString
  ) {
    
    /// 1. Leading cap
    
    /// Default
    
    switch theme.frameStyle {
      case .single:
        
        
        let leading = "\(BoxLine.structure(lineType).cap(.leading, from: config.theme.glyphSet))"
        
        attrString.appendString(leading, addsLineBreak: false)
        
        attrString.appendString(horizontalStructure(ofType: lineType), addsLineBreak: false)
        
        attrString.appendString(BoxLine.structure(lineType).cap(.trailing, from: config.theme.glyphSet), addsLineBreak: true)
        
        
      case .double:
        
        /// # Exterior
        ///
        /// Leading cap
        ///
        let leadingCap = "\(BoxLine.structure(lineType).cap(.leading, from: config.theme.glyphSet))"
        attrString.appendString(leadingCap, addsLineBreak: false)
        
        /// Repeating section
        ///
        if lineType != .divider {
          attrString.appendString(
            horizontalStructure(
              ofType: lineType,
              frameSection: .exterior
            ),
            addsLineBreak: false
          )
        }
        
        /// Trailing cap
        ///
        attrString.appendString(BoxLine.structure(lineType).cap(.trailing, from: config.theme.glyphSet), addsLineBreak: true)
        
        
        /// # Interior
        ///
        /// Leading vertical wall part
        ///
        let interiorCap = BoxPart.vertical(.exterior).character(from: self.config.theme.glyphSet)
        attrString.appendString(interiorCap, addsLineBreak: false)
        
        /// Space
        attrString.appendString(" ", addsLineBreak: false)
        
        /// Leading cap
        attrString.appendString(leadingCap, addsLineBreak: false)
        
        attrString.appendString(
          horizontalStructure(
            ofType: lineType,
            frameSection: .interior
          ),
          addsLineBreak: true
        )
        
        
        
        
        
      case .shadow:
        break
        
      case .intertwined:
        break
        
    }
    


    
  }
  
  func buildTextLine(
    _ lineType: BoxLine.Text,
    text: String,
    theme: Theme,
    /// Line number support coming later
//    lineCount: Int? = nil,
    attrString: inout AttributedString
  ) {
    
    
    
    switch theme.frameStyle {
      case .single:
        
        
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
        
        
      case .double:
        
        /// # Exterior
        ///
        /// Set up leading cap
        ///
        
        let leadingCap: String = "\( BoxLine.text(lineType).cap(.leading, from: config.theme.glyphSet))"
        
        let doubledLeadingCap = leadingCap + leadingCap
        
        attrString.appendString(doubledLeadingCap, addsLineBreak: false)
        
        
        
        
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
        
        
      case .shadow, .intertwined:
        break
        
    }
    
    
  }
  
  enum DoubleFrameSection {
    case interior
    case exterior
  }
  
  
  /// This function should *only* return the repeating part, no caps
  ///
  private func horizontalStructure(
    ofType structure: BoxLine.Structure,
    frameSection: DoubleFrameSection? = nil
  ) -> String {
    
    /// Structural elements
//    var output = AttributedString()
    
    let partToRepeat = structure.repeatablePart(from: config.theme.glyphSet)
    
    /// Default
    
    var output: String
    
    
    if let section = frameSection {

      switch section {
        case .interior:
          
          var adjustedWidth: Int = self.config.width - 4
          let result = String(repeating: partToRepeat, count: adjustedWidth)
          output = result
          
        case .exterior:
          var adjustedWidth: Int = self.config.width - 2
          let result = String(repeating: partToRepeat, count: adjustedWidth)
          output = result
      }

    } else {
      
      let result = String(repeating: partToRepeat, count: adjustedBoxWidth(for: .structure(.top)))
      
      output = result
    }
    
    
    
    

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
