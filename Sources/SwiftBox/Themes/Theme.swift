//
//  Themes.swift
//  Helpers
//
//  Created by Dave Coleman on 23/8/2024.
//

import SwiftUI
import BaseStyles

public extension SwiftBox {
  
  struct Theme {
    
    var glyphSet: GlyphSet
    
    /// This is only relevant for SwiftUI views, not the console output
    var colour: ColourSet
    var frameStyle: FrameStyle
    var padding: Int
    
    public init(
      glyphSet: GlyphSetPreset = .sharp,
      colour: ColourSet = .default,
      frameStyle: FrameStyle = .single,
      padding: Int = 1
    ) {
      self.glyphSet = glyphSet.glyphSet
      self.colour = colour
      self.frameStyle = frameStyle
      self.padding = padding
    }
  }
}
