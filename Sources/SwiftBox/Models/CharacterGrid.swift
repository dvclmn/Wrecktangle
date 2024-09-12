//
//  CharacterGrid.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

import Foundation

public extension SwiftBox.BoxGlyph {
  
  struct CharacterGrid {
    private var grid: [[Character]]
    let rows: Int
    let columns: Int
    
    init(rows: Int, columns: Int, defaultValue: Character = " ") {
      self.rows = rows
      self.columns = columns
      self.grid = Array(repeating: Array(repeating: defaultValue, count: columns), count: rows)
    }
    
    subscript(row: Int, column: Int) -> Character {
      get {
        precondition(isValidIndex(row: row, column: column), "Index out of range")
        return grid[row][column]
      }
      set {
        precondition(isValidIndex(row: row, column: column), "Index out of range")
        grid[row][column] = newValue
      }
    }
    
    private func isValidIndex(row: Int, column: Int) -> Bool {
      return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    func getRow(_ row: Int) -> [Character] {
      precondition(row >= 0 && row < rows, "Row index out of range")
      return grid[row]
    }
    
    func getColumn(_ column: Int) -> [Character] {
      precondition(column >= 0 && column < columns, "Column index out of range")
      return grid.map { $0[column] }
    }
    
    mutating func setRow(_ row: Int, to characters: [Character]) {
      precondition(row >= 0 && row < rows, "Row index out of range")
      precondition(characters.count == columns, "Invalid number of characters for row")
      grid[row] = characters
    }
    
    mutating func setColumn(_ column: Int, to characters: [Character]) {
      precondition(column >= 0 && column < columns, "Column index out of range")
      precondition(characters.count == rows, "Invalid number of characters for column")
      for (index, char) in characters.enumerated() {
        grid[index][column] = char
      }
    }
  }
}
