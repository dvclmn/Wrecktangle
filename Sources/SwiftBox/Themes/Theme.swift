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
    
    public var glyphSet: GlyphSet
    
    /// This is only relevant for SwiftUI views, not the console output
    public var colour: ColourSet
    public var frameStyle: FrameStyle
    public var shadow: BoxShadow
    public var padding: Int
    
    public init(
      glyphSet: GlyphSet = .sharp,
      colour: ColourSet = .default,
      frameStyle: FrameStyle = .single,
      shadow: BoxShadow = BoxShadow(),
      padding: Int = 1
    ) {
      self.glyphSet = glyphSet
      self.colour = colour
      self.frameStyle = frameStyle
      self.shadow = shadow
      self.padding = padding
    }
  }
}
