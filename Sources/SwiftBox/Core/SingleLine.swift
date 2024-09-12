//
//  SingleLine.swift
//  SwiftBox
//
//  Created by Dave Coleman on 24/8/2024.
//

import Foundation

public extension SwiftBox {
  
  func buildLine(
    _ line: BoxLine,
    attrString: inout AttributedString
  ) {
    
    let leadingPart: BoxPart
    let trailingPart: BoxPart
    var text: String? = nil
    
    switch line {
      case .top:
        leadingPart = partPreset(for: .cornerTopLeading)
        trailingPart = partPreset(for: .cornerTopTrailing)
        
      case .bottom:
        leadingPart = partPreset(for: .cornerBottomLeading)
        trailingPart = partPreset(for: .cornerBottomTrailing)
        
      case .divider:
        leadingPart = partPreset(for: .joinLeading)
        trailingPart = partPreset(for: .joinTrailing)
        
      case .header(let headerText):
        text = headerText
        leadingPart = partPreset(for: .vertical)
        trailingPart = partPreset(for: .vertical)
        
      case .content(let contentText):
        text = contentText
        leadingPart = partPreset(for: .vertical)
        trailingPart = partPreset(for: .vertical)
        
    }
    
    let leadingString = leadingPart.output
    let trailingString = trailingPart.output
    
    
    if let text = text {
      
      let cappedText = leadingString + text + trailingString
      attrString.appendString(cappedText, addsLineBreak: true)
      
      
    } else {
      
      let cappedText = leadingString + trailingString
      attrString.appendString(cappedText, addsLineBreak: true)
      
    }
    
    print(leadingPart)
    
    
    
//
//    
//    
    
//    let part = partPreset(for: .corner(.topTrailing), with: .threeByTwo)
//    
//    print(part)
//    
//    if type.isStructural {
//      
//    } else {
//      
//    }
      
//
//      buildStructuralLine(type, attrString: &<#T##AttributedString#>)(
//        lineType,
//        text: string,
//        theme: theme,
//        attrString: &attrString
//      )
//        
//        
//      case .text(let lineType):
//        
//        if let string = string {
//          buildTextLine(
//            lineType,
//            text: string,
//            theme: theme,
//            attrString: &attrString
//          )
//        }
//
    
  }

  func buildStructuralLine(
    _ lineType: BoxLine,
    attrString: inout AttributedString
  ) {
    
//    
//    
//    let leading = cap(.leading, line: lineType)
//    let trailing = cap(.trailing, line: .structure(lineType))

//    switch theme.frameStyle {
//      case .single:
//        
//        /// Leading cap
//        ///
//        
//        attrString.appendString(partPreset(for: .corner(.), with: BoxGlyph.Resolution), addsLineBreak: false)
//        
//        /// Repeating section
//        ///
//        attrString.appendString(horizontalStructure(ofType: lineType), addsLineBreak: false)
//        
//        /// Trailing cap
//        ///
//        let trailing = cap(.trailing, line: .structure(lineType))
//        attrString.appendString(trailing, addsLineBreak: true)
//        
//        
//      case .double:
//        
//        /// # First line
//        ///
//        /// Leading cap
//        ///
//        let leading = cap(.leading, line: .structure(lineType))
//        attrString.appendString(leading, addsLineBreak: false)
//        
//        /// Repeating section
//        ///
////        if lineType != .divider {
//          attrString.appendString(
//            horizontalStructure(
//              ofType: lineType,
//              frameSection: .exterior
//            ),
//            addsLineBreak: false
//          )
////        }
//        
//        /// Trailing cap
//        ///
//        
//        attrString.appendString(trailing, addsLineBreak: true)
//        
//        
//        /// # Second line
//        ///
//        /// Leading vertical wall part (not a cap, that comes after the space)
//        ///
//        let interiorCap = character(for: BoxGlyph.vertical(.exterior))
//        attrString.appendString(interiorCap, addsLineBreak: false)
//        
//        /// Space
//        attrString.appendString(" ", addsLineBreak: false)
//        
//        /// Leading cap
//        attrString.appendString(leading, addsLineBreak: false)
//        
//        attrString.appendString(
//          horizontalStructure(
//            ofType: lineType,
//            frameSection: .interior
//          ),
//          addsLineBreak: false
//        )
//        
//        
//        attrString.appendString(trailing, addsLineBreak: false)
//        
//        /// Space
//        attrString.appendString(" ", addsLineBreak: false)
//        attrString.appendString(interiorCap, addsLineBreak: true)
//
//        
//        
//        
//      case .shadow:
//        break
//        
//      case .intertwined:
//        break
        
//    }
    


    
  }
  
  func buildTextLine(
    _ lineType: SwiftBox.BoxLine,
    text: String,
    /// Line number support coming later
//    lineCount: Int? = nil,
    attrString: inout AttributedString
  ) {
//    
//    let leading = cap(.leading, line: .text(lineType))
//    let trailing = cap(.trailing, line: .text(lineType))
//    
//    switch theme.frameStyle {
//        
//        
//        // MARK: - Single frame
//      case .single:
//        
//        /// Set up leading cap
//        ///
//        
//        attrString.appendString(leading, addsLineBreak: false)
//        //    attrString.appendString(lineType.cap(.leading, from: config.theme.glyphSet))
//        
//        /// Leading space
//        ///
//        
//        let paddingCount = self.config.theme.padding
//        let paddingCharacter = self.config.metrics.invisibles ? Invisibles.space.character : " "
//        
//        let paddingString = String(repeating: paddingCharacter, count: paddingCount)
//        
//        attrString.appendString(paddingString, addsLineBreak: false)
//        
//        /// Line numbers
//        ///
//        
//        //    if let lineCount = lineCount, self.config.metrics.lineNumbers {
//        //      if lineCount <= 9 {
//        //        attrString.appendString(" ")
//        //      }
//        //      attrString.appendString(lineCount.description)
//        //      attrString.appendString("  ")
//        //
//        //    }
//        
//        /// Add the reflowed text
//        ///
//        /// Note: Using `+=` on two `AttributedString`s will keep the attributes
//        /// for each, provided... something. Can't remember. Will need to keep an eye
//        /// on this and try to remember how it works.
//        ///
//        let reflowedString = AttributedString(text)
//        //    let reflowedString = AttributedString(text, attributes: container(for: .primary))
//        attrString += reflowedString
//        
//        
//        //    paddingString.mergeAttributes(container(for: .tertiary))
//        
//        /// Add this padding to the output string
//        ///
//        //    attrString += paddingString
//        
//        /// Add trailing space
//        attrString.appendString(paddingString, addsLineBreak: false)
//        
//        /// Trailing cap
//        ///
//        attrString.appendString(trailing, addsLineBreak: false)
//        
//        /// And ensure that the line breaks, ready for the next one
//        attrString.addLineBreak()
//        
//        
//        
//        // MARK: - Double frame
//      case .double:
//        
//        /// # Exterior
//        ///
//        /// Set up leading cap
//        ///
//        
//        let doubledLeadingCap = "\(leading)" + " " + "\(leading)"
//        
//        attrString.appendString(doubledLeadingCap, addsLineBreak: false)
//        
//        
//        
//        
//        /// Leading space before text
//        ///
//        let paddingCount = self.config.theme.padding
//        let paddingCharacter = self.config.metrics.invisibles ? Invisibles.space.character : " "
//        let paddingString = String(repeating: paddingCharacter, count: paddingCount)
//        attrString.appendString(paddingString, addsLineBreak: false)
//
//        /// Actual text
//        ///
//        let reflowedString = AttributedString(text)
//        attrString += reflowedString
//
//        
//        /// Add trailing space
//        attrString.appendString(paddingString, addsLineBreak: false)
//        
//        
//        /// Trailing cap
//        ///
//        
//        let trailingDoubleCap = "\(trailing)" + " " + "\(trailing)"
//        
//        attrString.appendString(trailingDoubleCap, addsLineBreak: false)
//        
//        /// And ensure that the line breaks, ready for the next one
//        attrString.addLineBreak()
//        
//        
//      case .shadow, .intertwined:
//        break
//        
//    }
//    
    
  }
  
  enum DoubleFrameSection {
    case interior
    case exterior
  }
  
  
  /// This function should *only* return the repeating part, no caps
  ///
  private func horizontalStructure(
    type: SwiftBox.BoxLine,
    frameSection: DoubleFrameSection? = nil
  ) -> String {
    
    /// Structural elements
//    var output = AttributedString()
    
//    let partToRepeat = character(for: .horizontal(.exterior))
//    
//    
//    
//    /// Default
//    
//    var output: String
//    
//    
//    if let section = frameSection {
//
//      switch section {
//        case .interior:
//          
//          let adjustedWidth: Int = self.config.width - 6
//          let result = String(repeating: partToRepeat, count: adjustedWidth)
//          output = result
//          
//        case .exterior:
//          let adjustedWidth: Int = self.config.width - 2
//          let result = String(repeating: partToRepeat, count: adjustedWidth)
//          output = result
//      }
//
//    } else {
//      
//      let result = String(repeating: partToRepeat, count: adjustedBoxWidth(for: .structure(.top)))
//      
//      output = result
//    }
//    
//    
//    
//    
//
////    output.setAttributes(container(for: .secondary))
//    return output
    
    return "horizontal"
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
