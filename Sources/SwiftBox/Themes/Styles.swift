//
//  Theme+Model.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import SwiftUI

extension SwiftBox {
  
  public struct Theme {
    
    var glyphSet: Theme.GlyphSet
    var styles: Theme.GlyphStyle
    
    public init(
      glyphSet: Theme.GlyphSet = .init(),
      styles: Theme.GlyphStyle = .init()
    ) {
      self.glyphSet = glyphSet
      self.styles = styles
    }
    
    public struct StylePreset {
      var primary: Theme.AttributeSet      // Text
      var secondary: Theme.AttributeSet    // Box frame
      var tertiary: Theme.AttributeSet     // Invisibles
      var accent: Theme.AttributeSet       // Subtle accents
    }
    
    public struct AttributeSet {
      
      var foreground: Color
      var background: Color
      
      var container: AttributeContainer {
        var attrContainer = AttributeContainer()
        attrContainer.foregroundColor = self.foreground
        attrContainer.backgroundColor = self.background
        
        return attrContainer
      }
    } // END attribute set

  }
  
  
}



