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
      type: .top,
      string: nil,
      attrString: &output
    )
    
    
    
    //    output.quickHighlight()
    
    /// Content width, adjusted to take structural elements into account
    
    
    /// Header
    
    if let headerText = self.header {
      
      let headerLines: [String] = headerText.reflowText(
        width: adjustedBoxWidth(for: .header()),
        maxLines: config.headerLineLimit,
        paddingCharacter: Invisibles.ifNeeded(.space, isShowing: config.metrics.invisibles)
      )
      
      for line in headerLines {
        
        self.buildLine(
          type: .header(line),
          attrString: &output
        )
        
      }
    }
    
    /// Divider
    self.buildLine(type: .divider, attrString: &output)
    
    
    /// Content
    
    let contentLines: [String] = self.content.reflowText(
      width: adjustedBoxWidth(for: .content),
      maxLines: config.contentLineLimit,
      paddingCharacter: Invisibles.ifNeeded(.space, isShowing: config.metrics.invisibles)
    )
    
    for line in contentLines {
      
      self.buildLine(
        type: .content,
        string: line,
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
    self.buildLine(type: .bottom, attrString: &output)
    
    
    
    return output
  }
  

  func adjustedBoxWidth(
    for type: BoxLine
  ) -> Int {
    
    var textPadding: Int
    
    if type.isStructural {
      /// Don't want spaces in our structural lines
      textPadding = 0
      
    } else {
      
      /// Extra space on either side of text lines
      textPadding = (self.config.theme.padding * 2)
    }
    
    let structure: Int = self.config.theme.frameStyle.resolution.columns
    
    let totalReserved: Int = textPadding + structure
    let result = self.config.width - totalReserved
    
    return result
  }
  
  
  
  
  
  
}
