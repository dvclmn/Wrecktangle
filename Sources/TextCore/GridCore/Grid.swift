//
//  Grid.swift
//  SwiftBox
//
//  Created by Dave Coleman on 28/8/2024.
//

import Foundation

public typealias Artwork = [[Character]]


public extension Artwork {
  static let `default`: Artwork = [["N"],["o"],[" "],["a"],["r"],["t"]]
  
  static let empty: Artwork = [[Character("")]]
}

extension GlyphGrid {
  
  public static func createEmpty(
    rows: Int,
    columns: Int,
    fontName: String = "SF Mono",
    fontSize: CGFloat = 15
  ) -> GlyphGrid {
    let cell = GlyphCell(fontName: fontName, fontSize: fontSize)
    let dimensions = GridDimensions(rows: rows, columns: columns)
    
    return GlyphGrid(
      cell: cell,
      dimensions: dimensions,
      type: .canvas(Artwork.empty)
    )
  }
  
  public static func createWithArtwork(_ artwork: Artwork, fontName: String = "SF Mono", fontSize: CGFloat = 15) -> GlyphGrid {
    let rows = artwork.count
    let columns = artwork.map { $0.count }.max() ?? 0
    
    let cell = GlyphCell(fontName: fontName, fontSize: fontSize)
    let dimensions = GridDimensions(rows: rows, columns: columns)
    
    return GlyphGrid(
      cell: cell,
      dimensions: dimensions,
      type: .canvas(artwork)
    )
  }
  
  public static func createInterface(rows: Int, columns: Int, fontName: String = "SF Mono", fontSize: CGFloat = 15) -> GlyphGrid {
    let cell = GlyphCell(fontName: fontName, fontSize: fontSize)
    let dimensions = GridDimensions(rows: rows, columns: columns)
    
    return GlyphGrid(
      cell: cell,
      dimensions: dimensions,
      type: .interface
    )
  }
  
  
  
  
  
  
//  public static func createForArtwork(
//    _ artwork: Artwork,
//    fontName: String = "SF Mono",
//    fontSize: CGFloat = 15
//    
//  ) -> GlyphGrid {
//    
//    let rows = artwork.count
//    let columns = artwork.map { $0.count }.max() ?? 0
//    
//    let cell = GlyphCell(fontName: fontName, fontSize: fontSize)
//    let dimensions = GridDimensions(rows: rows, columns: columns)
//    
//    return GlyphGrid(
//      cell: cell,
//      dimensions: dimensions,
//      type: .canvas(
//    )
//  }
  
  
//  public static let example: GlyphGrid = GlyphGrid(cell: .example, dimensions: .example, type: .canvas)
  
  public func gridPosition(for location: CGPoint, zoomLevel: CGFloat = 1.0) -> GridPosition {
    switch type {
      case .interface:
        return GridPosition(
          row: Int(location.y / cell.size.height),
          col: Int(location.x / cell.size.width)
        )
      case .canvas:
        return GridPosition(
          row: Int(location.y / (cell.size.height * zoomLevel)),
          col: Int(location.x / (cell.size.width * zoomLevel))
        )
    }
  }
  
  public func gridPosition(for location: CGPoint) -> GridPosition {
    let row = Int(location.y / cell.size.height)
    let col = Int(location.x / cell.size.width)
    return GridPosition(row: row, col: col)
  }
  
  public func isValidPosition(_ position: GridPosition) -> Bool {
    return position.row >= 0 && position.row < dimensions.rows &&
    position.col >= 0 && position.col < dimensions.columns
  }
  
  public func cgRect(for position: GridPosition) -> CGRect {
    let origin = CGPoint(x: CGFloat(position.col) * cell.size.width,
                         y: CGFloat(position.row) * cell.size.height)
    return CGRect(origin: origin, size: cell.size)
  }
}

public extension GridDimensions {
  
  /// Calculate the number of cells (rows and columns) of a given size (`cellSize`), that can evenly
  /// fit within a window (or other space, sidebar, etc) of a given size (`cgSize`).
  ///
  
  
  static func calculateDimensions(
    cgSize: CGSize,
    cellSize: CGSize
  ) -> GridDimensions {
    let cgWidthSafe: CGFloat = max(1, cgSize.width)
    let cgHeightSafe: CGFloat = max(1, cgSize.height)
    
    let cellWidthSafe: CGFloat = max(1, cellSize.width)
    let cellHeightSafe: CGFloat = max(1, cellSize.height)
    
    let columns = Int(cgWidthSafe / cellWidthSafe)
    let rows = Int(cgHeightSafe / cellHeightSafe)
    
    return GridDimensions(rows: rows, columns: columns)
  }
  
  
  
  //  mutating func cellCount(
  //    cgSize: CGSize,
  //    cellSize: CGSize
  //  ) {
  //
  //    //    guard !cgSize.widthOrHeightIsZero else { return .zero }
  //
  //    let cgWidthSafe: CGFloat = max(1, cgSize.width)
  //    let cgHeightSafe: CGFloat = max(1, cgSize.height)
  //
  //    let cellWidthSafe: CGFloat = max(1, cellSize.width)
  //    let cellHeightSafe: CGFloat = max(1, cellSize.height)
  //
  //    let columns = Int(cgWidthSafe / cellWidthSafe)
  //    let rows = Int(cgHeightSafe / cellHeightSafe)
  //
  //    //    let safeWidth = max(2, width - 1) // Seems to need one shaved off?
  //    //    let safeHeight = max(2, height - 1)
  //
  ////    let result = GridDimensions(rows: rows, columns: columns)
  //
  //    self.rows = rows
  //    self.columns = columns
  //
  ////    return result
  //  }
  
  //  static func cellColumnCount(
  //    for width: CGFloat,
  //    cellSize: CGSize
  //  ) -> Int {
  //
  //    let size = CGSize(width: width, height: .zero)
  //
  //    let result = GridDimensions.cellCount(cgSize: size, cellSize: cellSize).columns
  //
  //    return result
  //  }
  
}
