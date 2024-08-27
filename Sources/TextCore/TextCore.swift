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

public struct CellCount: Equatable {
  public var rows: Int
  public var columns: Int
  
  public init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
  }
}

extension CellCount {
  public static let zero = CellCount(rows: 0, columns: 0)
}

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
  
  

  /// Get cell size when you don't yet have the `NSFont`
  ///
  public static func cellSize(
    fontName: String,
    fontSize: CGFloat = 15,
    zoom: CGFloat? = nil
  ) -> CGSize {
    
    guard let font = NSFont.init(name: fontName, size: fontSize) else { return .zero }
    
    return cellSize(for: font)
    
  }
  
  /// Get cell size when already have the `NSFont`
  ///
  public static func cellSize(for font: NSFont, zoom: CGFloat? = nil) -> CGSize {
    
    let rect: NSRect = font.boundingRect(forGlyph: NSGlyph("M"))
    
    var size: CGSize = .zero
    
    if let zoom = zoom {
      let zoomedWidth = rect.width * zoom
      let zoomedHeight = rect.height * zoom
      size = CGSize(width: zoomedWidth, height: zoomedHeight)
    } else {
      size = CGSize(width: rect.width, height: rect.height)
    }
    
    return size
    
  }
  
  
  
  /// Give a window size, how many cells (rows and columns) can neatly fit?
  ///
  public static func cellCount(
    cgSize: CGSize,
    cellSize: CGSize
  ) -> CellCount {

    let width = Int(cgSize.width / cellSize.width)
    let height = Int(cgSize.height / cellSize.height)
    
    let safeWidth = max(2, width - 1) // Seems to need one shaved off?
    let safeHeight = max(2, height - 1)
    
    let result = CellCount(rows: safeHeight, columns: safeWidth)
    
    return result
  }
  
  public static func cellColumnCount(
    for width: CGFloat,
    cellSize: CGSize
  ) -> Int {
    
    let size = CGSize(width: width, height: .zero)
    let result = TextCore.cellCount(cgSize: size, cellSize: cellSize).columns
    
    return result
  }
  
  
  
} // END textcore

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


