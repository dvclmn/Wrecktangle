//
//  Characters.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUI

extension SwiftBox {
  

  public enum Invisibles {
    case line(LineType)
    case space
    case tab
    case padding
    case paddingAlt
    
    public enum LineType {
      case new
      case end
    }
    
    public var character: Character {
      switch self {
        case .line(.new): "¬"
        case .line(.end): "¶"
        case .space: "•"
        case .tab: "→"
        case .padding: ","
        case .paddingAlt: "."
      }
    }
  }
 
}

extension SwiftBox.Theme.GlyphStyle {
  
  public struct ColorSet {
    var foreground: Color
    var background: Color?
    
    public init(foreground: Color, background: Color? = nil) {
      self.foreground = foreground
      self.background = background
    }
    
    var container: AttributeContainer {
      var attrContainer = AttributeContainer()
      attrContainer.foregroundColor = self.foreground
      attrContainer.backgroundColor = self.background
      
      return attrContainer
    }
  }
}


