//
//  Grid.swift
//  SwiftBox
//
//  Created by Dave Coleman on 28/8/2024.
//

import Foundation


extension GlyphGrid {

  public func gridPosition(for location: CGPoint, zoomLevel: CGFloat = 1.0) -> GridPosition {
      switch type {
        case .interface:
          return GridPosition(
            row: Int(location.y / cell.cellSize.height),
            col: Int(location.x / cell.cellSize.width)
          )
        case .canvas:
          return GridPosition(
            row: Int(location.y / (cell.cellSize.height * zoomLevel)),
            col: Int(location.x / (cell.cellSize.width * zoomLevel))
          )
      }
    }
    
    public func gridPosition(for location: CGPoint) -> GridPosition {
      let row = Int(location.y / cell.cellSize.height)
      let col = Int(location.x / cell.cellSize.width)
      return GridPosition(row: row, col: col)
    }
    
    public func isValidPosition(_ position: GridPosition) -> Bool {
      return position.row >= 0 && position.row < dimensions.rows &&
      position.col >= 0 && position.col < dimensions.columns
    }
    
    public func cgRect(for position: GridPosition) -> CGRect {
      let origin = CGPoint(x: CGFloat(position.col) * cell.cellSize.width,
                           y: CGFloat(position.row) * cell.cellSize.height)
      return CGRect(origin: origin, size: cell.cellSize)
    }
}
