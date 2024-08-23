//
//  Characters.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUI

extension SwiftBox {
  
  /// `━` horizontal exterior
  ///
  /// `─` horizontal interior
  ///
  /// `┯` horizontal join top
  ///
  /// `┷` horizontal join bottom
  ///
  ///
  /// `┃` vertical exterior
  ///
  /// `│` vertical interior
  ///
  /// `┠` vertical join leading
  ///
  /// `┨` vertical join trailing
  ///
  ///
  /// `┼` cross join
  ///
  ///
  /// `╭` corner top leading
  ///
  /// `╮` corner top trailing
  ///
  /// `╰` corner bottom leading
  ///
  /// `╯` corner bottom trailing
  ///
  
 
}

extension Theme {
  
  /// `Theme.GlyphSet` and `Theme.GlyphStyle` being seperate
  /// makes sense to me, because the two should operate totally independantly.
  ///
  /// Then having seperate `AttributeContainer`s for pre-defined semantic
  /// 'syntax' seems good too — such as text, invisibles, frames.
  ///
  public struct GlyphStyle {
    
    var text: ColorSet
    var invisibles: ColorSet
    var frame: ColorSet
    
    public init(
      text: ColorSet = .init(foreground: Color.purple.opacity(0.9)),
      accent: ColorSet = .init(foreground: Color.orange.opacity(0.8)),
      invisibles: ColorSet = .init(foreground: Color.secondary.opacity(0.6)),
      frame: ColorSet = .init(foreground: Color.secondary)
    ) {
      self.text = text
      self.invisibles = invisibles
      self.frame = frame
    }
  }
  
  public enum Invisibles {
    case line(LineType)
    case space
    case tab
    case padding
    
    public enum LineType {
      case new
      case end
    }
    
    public var character: String {
      switch self {
        case .line(.new): "¬"
        case .line(.end): "¶"
        case .space: "•"
        case .tab: "→"
        case .padding: ","
      }
    }
  }

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


