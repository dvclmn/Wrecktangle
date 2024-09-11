//
//  BoxHandler.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUI
import BaseHelpers
import TextCore
import AppKit

public extension SwiftBox {
  
  func drawBox() -> AttributedString {
    
    /// We start off with a fresh, blank attr. string. The 'build process' is based
    /// on concatenation, added section-by-section, starting from the top.
    var output = AttributedString()
    
    /// Add a width counter, according to user's preference ()
    output += TextCore.widthCounter(self.config.width, style: self.config.metrics.widthCounter)

    /// Box roof
    self.buildLine(
      type: .structure(.top),
      string: nil,
      theme: self.config.theme,
      attrString: &output
    )
    
//    output.quickHighlight()
    
    /// Content width, adjusted to take structural elements into account
    
   
    /// Header
    
    if let headerText = self.header {

      let headerLines: [String] = headerText.reflowText(
        width: adjustedBoxWidth(for: .text(.header)),
        maxLines: config.headerLineLimit,
        paddingCharacter: Invisibles.ifNeeded(.space, isShowing: config.metrics.invisibles)
      )
      
      for line in headerLines {
        
        self.buildLine(
          type: .text(.header),
          string: line,
          theme: self.config.theme,
          attrString: &output
        )
        
      }
    }
    
    /// Divider
    self.buildStructuralLine(
      .divider,
      theme: self.config.theme,
      attrString: &output
    )


    /// Content

    let contentLines: [String] = self.content.reflowText(
      width: adjustedBoxWidth(for: .text(.content)),
      maxLines: config.contentLineLimit,
      paddingCharacter: Invisibles.ifNeeded(.space, isShowing: config.metrics.invisibles)
    )

    for line in contentLines {

      self.buildLine(
        type: .text(.content),
        string: line,
        theme: self.config.theme,
        attrString: &output
      )
    }
    
    /// This could be made conditional on whether the theme's `GlyphSet`
    /// requires it, but this ensures that if there's an alternating frame part,
    /// the number of lines won't create alignment/joining issues
    ///
//    if !lineCount.isEven {
//      output += self.constructBoxLine(" ", lineType: .content)
//    }
    
    /// Box floor
    self.buildStructuralLine(
      .bottom,
      theme: self.config.theme,
      attrString: &output
    )
//    output += self.constructBoxLine(lineType: .bottom)
    
    
    
    return output
  }
  
  

  /// Width set aside for leading and trailing box parts and spaces
  /// and adjusted to compensate for the extra frame option
  ///
//  func calculateReservedHorizontalSpace(for lineType: BoxLine) -> Int {
//    
//    var reserved: Int = 4
//    
//    /// The header doesn't need to account for line numbers
//    ///
////    switch lineType {
////      case .text(.header):
////        if self.config.extraFrame {
////          reserved += 4
////        }
////        
////      case .text(.content):
////        if self.config.extraFrame {
////          reserved += 4
////        }
////        if self.config.metrics.lineNumbers {
////          reserved += 4
////        }
////      default: break
////    }
//    
//    return reserved
//  }
  
  
  func adjustedBoxWidth(
    for type: BoxLine
  ) -> Int {
    
    var textPadding: Int
    
    switch type {
      case .structure:
        /// Don't want spaces in our structural lines
        textPadding = 0
        
      case .text:
        /// Extra space on either side of text lines
        textPadding = (self.config.theme.padding * 2)
    }
    
    let structure: Int = self.config.theme.frameStyle.reservedSpace
    
    let totalReserved: Int = textPadding + structure
    let result = self.config.width - totalReserved
    
    return result
  }
  
  
  
  
  
  
}
