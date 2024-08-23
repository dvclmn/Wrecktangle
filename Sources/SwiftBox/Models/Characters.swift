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

extension Theme {
  
  /// `Theme.GlyphSet` and `Theme.GlyphStyle` being seperate
  /// makes sense to me, because the two should operate totally independantly.
  ///
  /// Then having seperate `AttributeContainer`s for pre-defined semantic
  /// 'syntax' seems good too — such as text, invisibles, frames.
  ///
//  public struct GlyphStyle {
//    
//    var text: AttributeSet
//    var invisibles: AttributeSet
//    var frame: AttributeSet
//    
//    public init(
//      text: AttributeSet = .init(foreground: Color.purple.opacity(0.9)),
//      accent: AttributeSet = .init(foreground: Color.orange.opacity(0.8)),
//      invisibles: ColorSet = .init(foreground: Color.secondary.opacity(0.6)),
//      frame: ColorSet = .init(foreground: Color.secondary)
//    ) {
//      self.text = text
//      self.invisibles = invisibles
//      self.frame = frame
//    }
//  }
  


}


extension Theme.GlyphStyle {
  
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


