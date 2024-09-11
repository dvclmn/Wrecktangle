//
//  BoxHandler.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUICore
import BaseHelpers
import TextCore
import AppKit

public extension SwiftBox {
  
  /// Rundown of how a box is constructed.
  ///
  /// 1.
  
  func drawBox() -> AttributedString {
    
    /// We start off with a fresh, blank attr. string. The 'build process' is based
    /// on concatenation, added section-by-section, starting from the top.
    var output = AttributedString()
    
    /// Add a width counter, if needed
    if self.config.metrics.widthCounter != .off {
      output += TextCore.widthCounter(self.config.width, style: self.config.metrics.widthCounter)
    }
    
    /// Box roof
    self.buildStructuralLine(.top, attrString: &output)
    
    output = output.quickHighlight
    
    
    /// Header
    
    if let headerText = self.header {
      
      let headerWidth: Int = self.config.width - calculateReservedHorizontalSpace(for: .text(.header))
      let headerLines: [String] = headerText.reflowText(width: headerWidth, maxLines: config.headerLineLimit)
      for line in headerLines {
        self.buildTextLine(.text(.header), text: line, attrString: &output)
        //      output += self.constructBoxLine(line, lineType: .header)
      }
    }
    
    /// Divider
    self.buildStructuralLine(.divider, attrString: &output)
//    output += self.constructBoxLine(lineType: .divider)
    
    /// Content
    let contentWidth: Int = self.config.width - calculateReservedHorizontalSpace(for: .text(.content))
    let contentLines: [String] = self.content.reflowText(width: contentWidth, maxLines: config.contentLineLimit)
    var contentLineCount: Int = 0
    for line in contentLines {
      contentLineCount += 1
      self.buildTextLine(.text(.content), text: line, attrString: &output)
//      output += self.constructBoxLine(line, lineType: .content)
    }
    
    /// This could be made conditional on whether the theme's `GlyphSet`
    /// requires it, but this ensures that if there's an alternating frame part,
    /// the number of lines won't create alignment/joining issues
    ///
//    if !lineCount.isEven {
//      output += self.constructBoxLine(" ", lineType: .content)
//    }
    
    /// Box floor
    self.buildStructuralLine(.bottom, attrString: &output)
//    output += self.constructBoxLine(lineType: .bottom)
    
    
    
    return output
  }
  
  

  /// Width set aside for leading and trailing box parts and spaces
  /// and adjusted to compensate for the extra frame option
  ///
  func calculateReservedHorizontalSpace(for lineType: BoxLine) -> Int {
    
    var reserved: Int = 4
    
    /// The header doesn't need to account for line numbers
    ///
//    switch lineType {
//      case .text(.header):
//        if self.config.extraFrame {
//          reserved += 4
//        }
//        
//      case .text(.content):
//        if self.config.extraFrame {
//          reserved += 4
//        }
//        if self.config.metrics.lineNumbers {
//          reserved += 4
//        }
//      default: break
//    }
    
    return reserved
  }
  
  
  
}
