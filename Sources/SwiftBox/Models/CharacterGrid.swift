//
//  CharacterGrid.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

import Foundation

public extension SwiftBox {
  
//  struct CharacterGrid {
//    private var grid: [[Character]]
//    let columns: Int
//    let rows: Int
//    let isRepeater: Bool
//    
//    init(
//      columns: Int,
//      rows: Int,
//      isRepeater: Bool = false,
//      initialValue: Character = "@"
//    ) {
//      self.columns = columns
//      self.rows = rows
//      self.isRepeater = isRepeater
//      self.grid = Array(repeating: Array(repeating: initialValue, count: columns), count: rows)
//    }
//    
//    subscript(column: Int, row: Int) -> Character {
//      get {
//        
//        precondition(isValidIndex(column: column, row: row), "Index out of range: column \(column), row \(row), grid size: \(columns)x\(rows)")
//        
//        if isRepeater {
//          /// For repeating parts, we only need single-width (column)
//          return grid[row][1]
//        } else {
//          return grid[row][column]
//        }
//      }
//      set {
//        precondition(isValidIndex(column: column, row: row), "Index out of range: column \(column), row \(row), grid size: \(columns)x\(rows)")
//        
//        if isRepeater {
//          grid[row][1] = newValue
//        } else {
//          grid[row][column] = newValue
//        }
//        
//        
//      }
//    }
//
//    
//    private func isValidIndex(column: Int, row: Int) -> Bool {
//      return row >= 0 && row < rows && column >= 0 && column < columns
//    }
    
//    func getColumn(_ column: Int) -> [Character] {
//      precondition(column >= 0 && column < columns, "Column index out of range")
//      return grid.map { $0[column] }
//    }
//
//    func getRow(_ row: Int) -> [Character] {
//      precondition(row >= 0 && row < rows, "Row index out of range")
//      return grid[row]
//    }
//    
//    mutating func setColumn(_ column: Int, to characters: [Character]) {
//      precondition(column >= 0 && column < columns, "Column index out of range")
//      precondition(characters.count == rows, "Invalid number of characters for column")
//      for (index, char) in characters.enumerated() {
//        grid[index][column] = char
//      }
//    }
//    
//    mutating func setRow(_ row: Int, to characters: [Character]) {
//      precondition(row >= 0 && row < rows, "Row index out of range")
//      precondition(characters.count == columns, "Invalid number of characters for row")
//      grid[row] = characters
//    }
    
//  }
}
