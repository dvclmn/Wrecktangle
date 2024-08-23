//
//  Theme+Model.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import SwiftUI

public struct Theme {
  
  var set: Theme.GlyphSet
  var styles: Theme.GlyphStyle
  
  public init(
    set: Theme.GlyphSet = .sharp,
    colours: Theme.GlyphStyle = .init()
  ) {
    self.set = set
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
  }
  
  //    var textForeground: Color {
  //      return colours.text.foreground
  //    }
  //    var invisiblesForeground: Color {
  //      return colours.invisibles.foreground
  //    }
  //    var frameForeground: Color {
  //      return colours.frame.foreground
  //    }
}


var container: AttributeContainer {
  var attrContainer = AttributeContainer()
  attrContainer.foregroundColor = self.foreground
  attrContainer.backgroundColor = self.background
  
  return attrContainer
  }
