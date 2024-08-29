//
//  Grid.swift
//  SwiftBox
//
//  Created by Dave Coleman on 28/8/2024.
//

import Foundation



extension GlyphGrid {
  
  public func characterCount() -> Int {
    
  var count: Int = 0
    
    if let artwork = self.artwork {
      
      count = artwork.reduce(0) { $0 + $1.count }
    }
    
    return count
  }
  
  public static func createEmpty(
    rows: Int,
    columns: Int,
    fontName: FontName = .menlo
  ) -> GlyphGrid {
    let cell = GlyphCell(fontName: fontName)
    let dimensions = GridDimensions(rows: rows, columns: columns)
    
    return GlyphGrid(
      cell: cell,
      dimensions: dimensions,
      type: .canvas(Artwork.empty)
    )
  }
  
  public static func createWithArtwork(_ artwork: Artwork, fontName: FontName = .menlo) -> GlyphGrid {
    let rows = artwork.count
    let columns = artwork.map { $0.count }.max() ?? 0
    
    let cell = GlyphCell(fontName: fontName)
    let dimensions = GridDimensions(rows: rows, columns: columns)
    
    return GlyphGrid(
      cell: cell,
      dimensions: dimensions,
      type: .canvas(artwork)
    )
  }
  
  public static func createInterface(rows: Int, columns: Int, fontName: FontName = .menlo) -> GlyphGrid {
    let cell = GlyphCell(fontName: fontName)
    let dimensions = GridDimensions(rows: rows, columns: columns)
    
    return GlyphGrid(
      cell: cell,
      dimensions: dimensions,
      type: .interface
    )
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
  
  
  
}
