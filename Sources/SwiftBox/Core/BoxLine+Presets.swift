//
//  BoxLine+Construct.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

import TextCore

public extension SwiftBox {
  
  func line(
    _ lineType: BoxLine.LineType
  ) -> String {
    
    switch lineType {
        
      case .top:
        
        let shadowLine = buildShadow(for: lineType, hasLineBreak: true)
        let structureLine = buildStructureLine(for: lineType, hasLineBreak: false)
        
        /// Note the order here, shadow first, then structure
        return shadowLine + structureLine
        
      case .divider:
        
        return buildStructureLine(for: lineType, hasLineBreak: false)
        
      case .bottom:
        
        let structureLine = buildStructureLine(for: lineType, hasLineBreak: true)
        let shadowLine = buildShadow(for: lineType, hasLineBreak: true)
        
        /// Structure first, then shadow
        return structureLine + shadowLine
        
        
      case .text(let content, let lineLimit):

        /// This uses `BoxLine`s text-based initialiser
        let lineResult = SwiftBox.BoxLine(
          text: content,
          lineLimit: lineLimit,
          remainingWidth: widthLeftForText,
          theme: theme
        )
        
        let lineString = lineResult.render()
        
        return lineString
        
    }
    
    
  } // END create line
  
  private func buildStructureLine(for preset: BoxLine.LineType, hasLineBreak: Bool) -> String {
    
    if let parts = preset.parts {
      
      let leading = BoxPart.create(parts.leading, theme: theme)
      let repeating = BoxPart.create(parts.repeater, theme: theme)
      let trailing = BoxPart.create(parts.trailing, theme: theme)
      
      /// This uses `BoxLine`s structure-based initialiser
      let lineResult = BoxLine(
        remainingWidth: widthLeftForText,
        repeater: repeating,
        leadingCap: leading,
        trailingCap: trailing,
        theme: theme
      )
      
      let lineString = lineResult.render()
      
      let result = lineString + (hasLineBreak ? "\n" : "")
      return result
      
    } else {
      return "nil"
    }
    
  }
  
  
  private func buildShadow(for lineType: BoxLine.LineType, hasLineBreak: Bool) -> String {
    
    if lineType.hasShadow(lightSource: shadow.lightSource) {
      
      let shadowWidth: Int = boxWidth
      let shadowRepeated = String(repeating: shadowCharacter, count: shadowWidth)
      
//      let shadowWithCaps = shadowCap().leading + shadowRepeated + shadowCap().trailing
      
      let result = shadowRepeated + (hasLineBreak ? "\n" : "")
//      let result = shadowWithCaps + (hasLineBreak ? "\n" : "")
      
      return result
      
    } else {
      return ""
    }
    
  }
}

