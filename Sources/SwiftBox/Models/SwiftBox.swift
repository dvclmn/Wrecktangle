//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

public struct SwiftBox {
  
  var header: String?
  var content: String
  var config: Config
  
  var attributedString: AttributedString {
    return self.drawBox()
  }
  
  public init(
    header: String? = nil,
    content: String,
    config: Config = .init()
  ) {
    self.header = header
    self.content = content
    self.config = config
  }

}

public extension SwiftBox {
  
  var theme: Theme {
    self.config.theme
  }
  
  var glyphSet: GlyphSet {
    self.config.theme.glyphSet
  }
  
  var boxWidth: Int {
    self.config.width
  }
  
  var widthLeftForText: Int {
    
    let padding = theme.padding
    let caps = theme.frameStyle.reservedWidth
    
    return boxWidth - (padding + caps)
    
  }
  
}
