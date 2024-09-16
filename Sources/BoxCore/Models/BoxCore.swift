//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

public typealias Box = BoxCore

public struct BoxCore {
  
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

public extension BoxCore {
  
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

    let shadowSpace = theme.shadow.reservedSpace
    let caps = theme.frameStyle.maximumGridSize.width.value
    
    return boxWidth - max(0, (caps + shadowSpace))
    
  }
  
  var shadow: BoxCore.Theme.Shadow {
    self.config.theme.shadow
  }
  
  var shadowCharacter: Character {
    self.config.theme.shadow.strength.character
  }
  
}
