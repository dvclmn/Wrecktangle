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
      case .top, .divider, .bottom:
        
        if let predefinedParts = preset.parts {
          
          let leading = BoxPart.create(predefinedParts.leading, theme: theme)
          let repeating = BoxPart.create(predefinedParts.repeater, theme: theme)
          let trailing = BoxPart.create(predefinedParts.trailing, theme: theme)

          let lineResult = BoxLine(repeater: repeating, leadingCap: leading, trailingCap: trailing)
          
          let lineString = lineResult.render(width: boxWidth(), theme: theme)
          
          let lineAndShadow = shadowCap(.leading) + lineString + shadowCap(.trailing)
          
          return lineAndShadow
          
        } else {
          return "nil"
        }
        
      case .text(let content, let lineLimit):
        
        let textPadding = String(repeating: invisibleIfNeeded(.space), count: theme.padding)
        let textContent = textPadding + content + textPadding
        
        let lineResult = SwiftBox.BoxLine(text: textContent, lineLimit: lineLimit, theme: theme)
        
        let lineString = lineResult.render(width: boxWidth(), theme: theme)
        
        let lineAndShadow = shadowCap(.leading) + lineString + shadowCap(.trailing)
        
        return lineAndShadow
        
      case .shadow:

        let shadowWidth: Int = boxWidth()
        let shadowRepeated = String(repeating: shadowCharacter, count: shadowWidth)
        
        let shadowWithCaps = shadowCap(.leading) + shadowRepeated + shadowCap(.trailing)
        
        return shadowWithCaps
    }
    
    
  } // END create line
  
  
 
}
