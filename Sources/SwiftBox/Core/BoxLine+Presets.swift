//
//  BoxLine+Construct.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

public extension SwiftBox {
  
  func line(
    _ preset: LinePreset
  ) -> String {
    
    
    /// This takes care of top, divider and bottom, just leaves text and shadow
    ///
    /// I should make this clearer in the code
    ///
    
    switch preset {
      case .top:
          
        let shadowLine = buildShadow(for: preset)
        let structureLine = buildStructureLine(for: preset)
        
        return shadowLine + structureLine
        
        
      case .divider:
          
        return buildStructureLine(for: preset)
        
          case .bottom:
        
        let shadowLine = buildShadow(for: preset)
        let structureLine = buildStructureLine(for: preset)
        
        return structureLine + shadowLine
        

      case .text(let content, let lineLimit):
        
        let textPadding = String(repeating: invisibleIfNeeded(.space), count: theme.padding)
        let textContent = textPadding + content + textPadding
        
        let lineResult = SwiftBox.BoxLine(text: textContent, lineLimit: lineLimit, theme: theme)
        
        let lineString = lineResult.render(width: boxWidth(), theme: theme)
        
        let lineAndShadow = shadowCap().leading + lineString + shadowCap().trailing
        
        return lineAndShadow
        
    }
    
    
  } // END create line
  
  private func buildStructureLine(for preset: LinePreset) -> String {
    
    if let parts = preset.parts {
      let leading = BoxPart.create(parts.leading, theme: theme)
      let repeating = BoxPart.create(parts.repeater, theme: theme)
      let trailing = BoxPart.create(parts.trailing, theme: theme)
      
      let lineResult = BoxLine(repeater: repeating, leadingCap: leading, trailingCap: trailing)
      
      let lineString = lineResult.render(width: boxWidth(), theme: theme)
      
      let lineAndShadow = shadowCap().leading + lineString + shadowCap().trailing
      
      return lineAndShadow
      
    } else {
      return "nil"
    }
    
  }
  
  private func buildShadow(for linePreset: LinePreset) -> String {
    
    if linePreset.hasShadow(lightSource: shadow.lightSource) {
      
      let shadowWidth: Int = boxWidth() - 2
      let shadowRepeated = String(repeating: shadowCharacter, count: shadowWidth)
      
      let shadowWithCaps = shadowCap().leading + shadowRepeated + shadowCap().trailing
      
      return shadowWithCaps

    } else {
      return ""
    }
    
  }
}


public extension SwiftBox {
  
  /// This
  func shadowCap() -> (leading: String, trailing: String) {
    
    let shadowString = shadowCharacter.string
    
    switch shadow.lightSource {
        
      case .topLeading:
        return (" ", shadowString)
        
      case .topTrailing:
        return (shadowString, " ")
        
      case .bottomLeading:
        return (" ", shadowString)
        
      case .bottomTrailing:
        return (shadowString, " ")
        
    }
  }
}
