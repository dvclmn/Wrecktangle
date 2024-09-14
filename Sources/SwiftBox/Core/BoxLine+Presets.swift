//
//  BoxLine+Construct.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

import TextCore

public extension SwiftBox {
  
  func line(
    _ preset: LinePreset
  ) -> String {
    
    switch preset {
        
      case .top:
        
        let shadowLine = buildShadow(for: preset, hasLineBreak: true)
        let structureLine = buildStructureLine(for: preset, hasLineBreak: false)
        
        /// Note the order here, shadow first, then structure
        return shadowLine + structureLine
        
        
      case .divider:
        
        return buildStructureLine(for: preset, hasLineBreak: false)
        
      case .bottom:
        
        let structureLine = buildStructureLine(for: preset, hasLineBreak: true)
        let shadowLine = buildShadow(for: preset, hasLineBreak: true)
        
        /// Structure first, then shadow
        return structureLine + shadowLine
        
        
      case .text(let content, let lineLimit):
        
        let textPadding = String(repeating: invisibleIfNeeded(.space), count: theme.padding)
        let textContent = textPadding + content + textPadding
        
        /// This uses `BoxLine`s text-based initialiser
        let lineResult = SwiftBox.BoxLine(text: textContent, lineLimit: lineLimit, theme: theme)
        
        let lineString = lineResult.render(width: boxWidth(), theme: theme)
        
        let lineAndShadow = shadowCap().leading + lineString + shadowCap().trailing
        
        return lineAndShadow
        
    }
    
    
  } // END create line
  
  private func buildStructureLine(for preset: LinePreset, hasLineBreak: Bool) -> String {
    
    if let parts = preset.parts {
      
      let leading = BoxPart.create(parts.leading, theme: theme)
      let repeating = BoxPart.create(parts.repeater, theme: theme)
      let trailing = BoxPart.create(parts.trailing, theme: theme)
      
      /// Takes cue for shadow height from leading cap
      let shadowHeight: Int = leading.height
      
      /// This uses `BoxLine`s structure-based initialiser
      let lineResult = BoxLine(repeater: repeating, leadingCap: leading, trailingCap: trailing)
      
      let lineString = lineResult.render(width: boxWidth(), theme: theme)
      
      let lineAndShadow = shadowCap(height: shadowHeight).leading + lineString + shadowCap(height: shadowHeight).trailing
      
      let result = lineAndShadow + (hasLineBreak ? "\n" : "")
      return result
      
    } else {
      return "nil"
    }
    
  }
  
  
  private func buildShadow(for linePreset: LinePreset, hasLineBreak: Bool) -> String {
    
    if linePreset.hasShadow(lightSource: shadow.lightSource) {
      
      let shadowWidth: Int = boxWidth() - 2
      let shadowRepeated = String(repeating: shadowCharacter, count: shadowWidth)
      
      let shadowWithCaps = shadowCap().leading + shadowRepeated + shadowCap().trailing
      
      let result = shadowWithCaps + (hasLineBreak ? "\n" : "")
      
      return result
      
    } else {
      return ""
    }
    
  }
}


public extension SwiftBox {
  
  /// This
  func shadowCap(height: Int = 1) -> StringCaps {
    
    let shadowString = "?"
//        let shadowString = shadowCharacter.string
    
    let blank = "x"
    
    let result: StringCaps
    
    switch shadow.lightSource {
        
      case .topLeading:
        result = (blank, shadowString)
        
      case .topTrailing:
        result = (shadowString, blank)
        
      case .bottomLeading:
        result = (blank, shadowString)
        
      case .bottomTrailing:
        result = (shadowString, blank)
        
    } // END switch
    
    return result
    
    
  }
}
