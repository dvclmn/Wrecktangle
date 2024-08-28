//
//  GlyphGrid.swift
//  SwiftBox
//
//  Created by Dave Coleman on 28/8/2024.
//

import Foundation

public struct GlyphGrid: Equatable, Sendable {
  
  public var cell: GlyphCell
  public var dimensions: GridDimensions
  public var type: GridType
  
  public var artwork: Artwork?

  
  public init(
    cell: GlyphCell = GlyphCell(),
    dimensions: GridDimensions = GridDimensions(),
    type: GridType
  ) {
    self.cell = cell
    self.dimensions = dimensions
    self.type = type
  }
  
} // END GlyphGrid

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
  public internal(set) var size: CGSize
  
  public init(
    fontName: String = "SF Mono",
    fontSize: CGFloat = 15
  ) {
    self.fontName = fontName
    self.fontSize = fontSize
    self.size = GlyphCell.calculateCellSize(fontName: fontName, fontSize: fontSize)
  }

}


public struct GridDimensions: Equatable, Sendable {
  
  private var _rows: Int
  private var _columns: Int
  
  public var minValue: Int
  
  public var rows: Int {
    get { _rows }
    set { _rows = max(minValue, newValue) }
  }
  
  public var columns: Int {
    get { _columns }
    set { _columns = max(minValue, newValue) }
  }
  
  public init(
    rows: Int = 2,
    columns: Int = 2,
    minValue: Int = 2
  ) {
    self.minValue = minValue
    self._rows = max(minValue, rows)
    self._columns = max(minValue, columns)
  }
  
  public static let example: GridDimensions = GridDimensions(rows: 20, columns: 10)
}




//
//
//public struct GridDimensions: Equatable, Sendable {
//  public var rows: Int
//  public var columns: Int
//  
//  public init(
//    rows: Int = 10,
//    columns: Int = 10
//  ) {
//    self.rows = rows
//    self.columns = columns
//  }
//  
//  public static let example: GridDimensions = GridDimensions(rows: 20, columns: 10)
//  
//}


/// Now, you can use these structures in your app like this:
///
/// ```swift
/// // In your drawing code
/// if document.selectedCells.contains(glyphGrid.gridPosition(for: somePoint)) {
///   context.fill(glyphGrid.cgRect(for: selectedPosition),
///   with: .color(.blue.opacity(0.3)))
/// }
///
/// // Converting a point to a grid position
/// let position = glyphGrid.gridPosition(for: location)
///
/// // Checking if a position is valid
/// if glyphGrid.isValidPosition(position) {
///   // Do something with the valid position
/// }
/// ```
///

public enum GridType: Equatable, Sendable {
  case canvas(Artwork)
  case interface
}



public struct GridPosition: Hashable, Equatable, Sendable {
  public let row: Int
  public let col: Int
  
  public init(
    row: Int = 0,
    col: Int = 0
  ) {
    self.row = row
    self.col = col
  }
  
  
  
}

