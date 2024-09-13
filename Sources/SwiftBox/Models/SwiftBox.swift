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
  
  func boxWidth(_ includingShadow: Bool = true) -> Int {
    
    let shadowWidth: Int = includingShadow ? self.config.theme.shadow.reservedSpace : 0
    
    return self.config.width - shadowWidth
  }
  
  var widthLeftForText: Int {
    
    /// Note: Do not include shadow in here, shadow reserved space should
    /// be deducated from the *box* width, not internal content width.
    ///
    let padding = theme.padding * 2 // Either side
    let caps = theme.frameStyle.reservedWidth
    
    return boxWidth() - (padding + caps)
    
  }
  
  var shadow: SwiftBox.Theme.BoxShadow {
    self.config.theme.shadow
  }
  
  var shadowCharacter: Character {
    self.config.theme.shadow.strength.character
  }
  
}
