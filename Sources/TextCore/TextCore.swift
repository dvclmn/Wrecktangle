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


public struct LineCaps {
  var leading: String
  var trailing: String
  var hasPadding: Bool
  
  public init(
    _ leading: String,
    _ trailing: String,
    hasPadding: Bool = true
  ) {
    self.leading = leading
    self.trailing = trailing
    self.hasPadding = hasPadding
  }
}

public struct TextCore {
  
  static public func padLine(
    _ text: String = "",
    with paddingString: String = " ",
    toFill width: Int,
    alignment: Alignment = .center,
    sliceCharacter: Character = "@",
    caps: LineCaps? = nil, /// This is `String` in case of multi-character caps
    hasHorizontalPadding: Bool = true
  ) -> String {
    
    let horizontalPadding = hasHorizontalPadding ? " " : ""
    let horizontalPaddingWidth = (hasHorizontalPadding ? 2 : 0)
    
    var leadingCap: String = ""
    var trailingCap: String = ""
    var capsTotalWidth: Int = 0
    
    if let caps = caps {
      leadingCap = caps.leading
      trailingCap = caps.trailing
      capsTotalWidth += caps.hasPadding ? 2 : 0
    }
    
    capsTotalWidth += leadingCap.count + trailingCap.count
    
    let components = text.split(separator: sliceCharacter, omittingEmptySubsequences: false)
    
    let contentWidth = components.reduce(0) { $0 + $1.count }
    
    let availableSpace: Int = max(0, width - contentWidth - capsTotalWidth - horizontalPaddingWidth)
    
    
    /// This will distribute the padding based on alignment if no split was found
    if components.count <= 1 {
      let paddingCount = availableSpace
      let leftPadding: Int
      let rightPadding: Int
      
      switch alignment {
        case .leading:
          leftPadding = 0
          rightPadding = paddingCount
        case .trailing:
          leftPadding = paddingCount
          rightPadding = 0
        default: // .center
          leftPadding = paddingCount / 2
          rightPadding = paddingCount - leftPadding
      }
      
      return leadingCap +
      String(repeating: paddingString, count: leftPadding) +
      text +
      String(repeating: paddingString, count: rightPadding) +
      horizontalPadding + trailingCap
      
    } else {
      
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
      
    }
    
    
  } // END pad line
  
}


public extension CGSize {
  var widthOrHeightIsZero: Bool {
    return self.width.isZero || self.height.isZero
  }
}

public enum DimensionForCell {
  case width, height
}

//protocol Flouble {
//
//
//
//  var width:
//}

public extension BinaryFloatingPoint {
  
  func snapToCell(cellSize: CGSize, dimension: DimensionForCell = .width) -> CGFloat {
    
    let cellDimension = dimension == .width ? cellSize.width : cellSize.height
    
    if let value = self as? CGFloat {
      
      let multiplier = (value / cellDimension).rounded()
      return multiplier * cellDimension
      
    } else if let value = self as? Double {
      
      let multiplier = (value / cellDimension).rounded()
      return multiplier * cellDimension
      
    } else {
      
      return .zero
    }
    
    
    
  }
}

