//
//  TextCore.swift
//  SwiftBox
//
//  Created by Dave Coleman on 27/8/2024.
//

/// Common operations
///
/// 1. Find just enough whitespace to fill out a row of character to x-length
///

import SwiftUI
import BaseHelpers


public struct TextCore {
  
  static public func padLine(
    _ text: String = "", // May need a conditional for lines that just want to repeat a character, and not adjust for any content
    with paddingString: String = " ",
    toFill width: Int,
    sliceCharacter: Character = "@",
    caps: (String, String)? = nil, /// This is `String` in case of multi-character caps
    hasHorizontalPadding: Bool = true
  ) -> String {
    
    let horizontalPadding = hasHorizontalPadding ? " " : ""
    let horizontalPaddingWidth = (hasHorizontalPadding ? 2 : 0)
    
    var leadingCap: String = ""
    var trailingCap: String = ""
    let capWidth: Int = leadingCap.count + trailingCap.count
    
    if let (leading, trailing) = caps {
      leadingCap = leading
      trailingCap = trailing
    }
    
    let components = text.split(separator: sliceCharacter, omittingEmptySubsequences: false)
    
    let contentWidth = components.reduce(0) { $0 + $1.count }
    
    let availableSpace: Int = max(0, width - contentWidth - capWidth - horizontalPaddingWidth)
    
    
    /// This will return all the padding at the end of the string, if no split was found
    ///
    if components.count <= 1 {
      return text + String(repeating: paddingString, count: availableSpace)
    }
    
    let spacesPerSlice = availableSpace / (components.count - 1)
    let extraSpaces = availableSpace % (components.count - 1)
    
    /// Add the leading cap/padding, if present
    ///
    var result = leadingCap + horizontalPadding
    
    for (index, component) in components.enumerated() {
      result += component
      if index < components.count - 1 {
        let spaces = spacesPerSlice + (index < extraSpaces ? 1 : 0)
        result += String(repeating: paddingString, count: spaces)
      }
    }
    
    /// Add the trailing cap/padding, if present
    ///
    result += horizontalPadding + trailingCap
    
    return result
  } // END pad line
  
}


public extension CGSize {
  var widthOrHeightIsZero: Bool {
    return self.width.isZero || self.height.isZero
  }
}

public extension CGFloat {
  enum Dimension {
    case width, height
  }
  
  func snapToCell(cellSize: CGSize, dimension: Dimension = .width) -> CGFloat {
    let cellDimension = dimension == .width ? cellSize.width : cellSize.height
    let multiplier = (self / cellDimension).rounded()
    return multiplier * cellDimension
  }
}


public extension String {
  
  
  //  static func formatLine(
  //    content: String,
  //    width: Int,
  //    alignment: TextAlignment = .left,
  //    fill: Character = " ",
  //    leftCap: String = "",
  //    rightCap: String = "",
  //    trimming: Int = 0
  //  ) -> String {
  //    let contentWidth = content.count
  //    let capWidth = leftCap.count + rightCap.count
  //    let availableWidth = max(0, width - capWidth - trimming)
  //
  //    if contentWidth >= availableWidth {
  //      return leftCap + String(content.prefix(availableWidth)) + rightCap
  //    }
  //
  //    let padding = String(repeating: fill, count: availableWidth - contentWidth)
  //
  //    switch alignment {
  //      case .left:
  //        return leftCap + content + padding + rightCap
  //      case .center:
  //        let leftPad = String(repeating: fill, count: (availableWidth - contentWidth) / 2)
  //        let rightPad = String(repeating: fill, count: availableWidth - contentWidth - leftPad.count)
  //        return leftCap + leftPad + content + rightPad + rightCap
  //      case .right:
  //        return leftCap + padding + content + rightCap
  //    }
  //  }
}


