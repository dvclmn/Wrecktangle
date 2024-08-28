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


/// 1. `cellSize` is a stored property, not a computed one. This allows us to calculate it once and store the result.
///
/// 2. The `init` method only takes `fontName` and `fontSize`, and calculates `cellSize` during initialization.
///
/// 3. All properties are marked with `private(set)`, which means they can be read publicly but only modified within the struct.
///
/// 4. A private static method `calculateCellSize` is used to encapsulate the cell size calculation logic.
///
/// 5. An `updateFont` method is provided to change the font name or size. This method only recalculates the cell size if either the name or size actually changes.
///
/// You can use this struct like this:
///
/// ```swift
/// var cell = GlyphCell(fontName: "Menlo", fontSize: 12)
/// print(cell.cellSize) // Prints the calculated cell size
///
/// // Update just the font size
/// cell.updateFont(size: 14)
/// // Update both font name and size
/// cell.updateFont(name: "Courier", size: 16)
///
/// // This won't recalculate the cell size because neither name nor size changed
/// cell.updateFont(name: "Courier", size: 16)
/// ```
///
/// This approach ensures that:
/// - `cellSize` is always in sync with `fontName` and `fontSize`
/// - `cellSize` is only recalculated when necessary
/// - The expensive calculation is only done when the font actually changes
/// - The struct presents a clean public interface where `cellSize` can't be set directly
///
public struct GlyphCell: Equatable, Sendable {
  public private(set) var fontName: String
  public private(set) var fontSize: CGFloat
  public private(set) var cellSize: CGSize
  
  public init(fontName: String, fontSize: CGFloat) {
    self.fontName = fontName
    self.fontSize = fontSize
    self.cellSize = GlyphCell.cellSize(fontName: fontName, fontSize: fontSize)
  }
  
//  private static func calculateCellSize(
//    fontName: String,
//    fontSize: CGFloat
//  ) -> CGSize {
//    
//  }
  
  public mutating func updateFont(
    name: String,
    size: CGFloat
  ) {
//    let nameChanged = name != nil && name != fontName
//    let sizeChanged = size != nil && size != fontSize
//    
//    if nameChanged {
//      fontName = name!
//    }
//    if sizeChanged {
//      fontSize = size!
//    }
    
    
    cellSize = GlyphCell.cellSize(fontName: name, fontSize: size)
    
  }
}

public struct GridDimensions: Equatable, Sendable {
  public var rows: Int
  public var columns: Int
  
  public init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
  }
}


public struct GlyphGrid: Equatable, Sendable {
  public var cell: GlyphCell
  public var dimensions: GridDimensions
  
  public init(cell: GlyphCell, dimensions: GridDimensions) {
    self.cell = cell
    self.dimensions = dimensions
  }
}


public struct GridPosition: Hashable, Equatable, Sendable {
  public let row: Int
  public let col: Int
  
  public init(row: Int, col: Int) {
    self.row = row
    self.col = col
  }
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
  
}
extension GlyphCell {
  
  /// Get cell size when you don't yet have the `NSFont`
  ///
  public static func cellSize(
    fontName: String,
    fontSize: CGFloat = 14,
    zoom: CGFloat? = nil,
    minWidth: CGFloat = 1.5
  ) -> CGSize {
    
    guard let nsFont = NSFont.init(name: fontName, size: fontSize) else { return .zero }
    
    let fontMetrics: String = """
      Zoom: \(zoom ?? .zero)
      
      Cap height: \(nsFont.capHeight)
      Point size: \(nsFont.pointSize)
      Ascender height: \(nsFont.ascender)
      Fixed pitch?: \(nsFont.isFixedPitch)
      Leading value: \(nsFont.leading)
      Whole font rect: \(nsFont.boundingRectForFont)
      """
    
    print(fontMetrics)
    
    //    return cellSize(for: font)
    
    
    //    let rect: NSRect = font.boundingRect(forGlyph: NSGlyph("M"))
    
    //    let rect = font.boundingRectForFont
    
    
    
    let name = fontName as CFString
    
    let ctFont: CTFont = CTFontCreateWithName(name, fontSize, nil)
    
    let referenceGlyph: Character = "M"
    
    guard let cgGlyph = getGlyphForCharacter(referenceGlyph, font: ctFont) else {
      print("Couldn't get CGGlyph")
      return .zero
    }
    
    //    let glyphSize: NSSize = nsFont.advancement(forCGGlyph: cgGlyph)
    
    let glyphWidth: CGFloat = nsFont.advancement(forCGGlyph: cgGlyph).width
    
    let glyphHeight: CGFloat = nsFont.ascender - nsFont.descender + nsFont.leading
    
    //    let cellSize = CGSize(width: glyphSize.width, height: glyphHeight)
    
    //    let boundingRect: NSRect = nsFont.boundingRect(forCGGlyph: cgGlyph)
    
    var finalWidth: CGFloat
    var finalHeight: CGFloat
    
    if let zoom = zoom {
      finalWidth = glyphWidth * zoom
      finalHeight = glyphHeight * zoom
      
    } else {
      finalWidth = glyphWidth
      finalHeight = glyphHeight
    }
    
    let size = CGSize(width: max(minWidth, finalWidth), height: max(minWidth, finalHeight))
    print("Here is the final cell size: \(size)")
    
    return size
    
  }
  
  
  /// Get cell size when already have the `NSFont`
  ///
  //  public static func cellSize(for font: NSFont, zoom: CGFloat? = nil) -> CGSize {
  
  //  }
  
  public static func getGlyphForCharacter(_ character: Character, font: CTFont) -> CGGlyph? {
    
    let chars = [UniChar](String(character).utf16)
    var glyphs = [CGGlyph](repeating: 0, count: chars.count)
    
    let result = CTFontGetGlyphsForCharacters(font, chars, &glyphs, chars.count)
    
    if result {
      return glyphs.first
    } else {
      return nil
    }
  }
  
  
  
  
  
  /// Calculate the number of cells (rows and columns) of a given size (`cellSize`), that can evenly
  /// fit within a window (or other space, sidebar, etc) of a given size (`cgSize`).
  ///
  public static func cellCount(
    cgSize: CGSize,
    cellSize: CGSize
  ) -> GridDimensions {
    
    //    guard !cgSize.widthOrHeightIsZero else { return .zero }
    
    let cgWidthSafe: CGFloat = max(1, cgSize.width)
    let cgHeightSafe: CGFloat = max(1, cgSize.height)
    
    let cellWidthSafe: CGFloat = max(1, cellSize.width)
    let cellHeightSafe: CGFloat = max(1, cellSize.height)
    
    let columns = Int(cgWidthSafe / cellWidthSafe)
    let rows = Int(cgHeightSafe / cellHeightSafe)
    
    //    let safeWidth = max(2, width - 1) // Seems to need one shaved off?
    //    let safeHeight = max(2, height - 1)
    
    let result = GridDimensions(rows: rows, columns: columns)
    
    return result
  }
  
  public static func cellColumnCount(
    for width: CGFloat,
    cellSize: CGSize
  ) -> Int {
    
    let size = CGSize(width: width, height: .zero)
    let result = GlyphCell.cellCount(cgSize: size, cellSize: cellSize).columns
    
    return result
  }
  
} // END glyph cell extension
  


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


