//
//  CharacterGrid.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

import Foundation

public extension SwiftBox {
  
  struct CharacterGrid {
    private var grid: [[Character]]
    let columns: Int
    let rows: Int
    
    init(columns: Int, rows: Int, defaultValue: Character = "@") {
      self.columns = columns
      self.rows = rows
      self.grid = Array(repeating: Array(repeating: defaultValue, count: columns), count: rows)
    }
    
    
    subscript(column: Int, row: Int) -> Character {
      get {
        precondition(isValidIndex(column: column, row: row), "Index out of range: column \(column), row \(row), grid size: \(columns)x\(rows)")
        return grid[row][column]  // This is correct
      }
      set {
        precondition(isValidIndex(column: column, row: row), "Index out of range: column \(column), row \(row), grid size: \(columns)x\(rows)")
        grid[row][column] = newValue  // This is correct
      }
    }

    
    private func isValidIndex(column: Int, row: Int) -> Bool {
      return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    func getColumn(_ column: Int) -> [Character] {
      precondition(column >= 0 && column < columns, "Column index out of range")
      return grid.map { $0[column] }
    }

    func getRow(_ row: Int) -> [Character] {
      precondition(row >= 0 && row < rows, "Row index out of range")
      return grid[row]
    }
    
    mutating func setColumn(_ column: Int, to characters: [Character]) {
      precondition(column >= 0 && column < columns, "Column index out of range")
      precondition(characters.count == rows, "Invalid number of characters for column")
      for (index, char) in characters.enumerated() {
        grid[index][column] = char
      }
    }
    
    mutating func setRow(_ row: Int, to characters: [Character]) {
      precondition(row >= 0 && row < rows, "Row index out of range")
      precondition(characters.count == columns, "Invalid number of characters for row")
      grid[row] = characters
    }
    
  }
}
