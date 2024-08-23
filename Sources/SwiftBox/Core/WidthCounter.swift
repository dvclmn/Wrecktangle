//
//  WidthCounter.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

extension SwiftBox {
  enum WidthCounterDisplayStyle {
    case full
    case compact
  }

  func widthCounter(
    _ width: Int,
    style: WidthCounterDisplayStyle = .compact
  ) -> AttributedString {
    
    var result = AttributedString("")
    let adjustedWidth = width + 1 // To make up for starting from 1
    
    switch style {
      case .full:
        // First line: 10's (with leading zero)
        var tensLine = ""
        for i in 1..<adjustedWidth {
          tensLine += String((i / 10) % 10)
        }
        result.appendString(tensLine)
        result.addNewLine()
        
        // Second line: counting up by one
        var onesLine = ""
        for i in 1..<adjustedWidth {
          onesLine += String(i % 10)
        }
        result.appendString(onesLine)
        result.addNewLine()
        
      case .compact:
        var compactLine = "1"
        var i = 5
        while i <= width {
          let spaces = String(repeating: " ", count: i <= 9 ? 4 : 3)
          if i % 10 == 5 {
            compactLine += spaces + "· "
          } else {
            // Align two-digit numbers with the first digit over the marker
            if i >= 10 {
              compactLine += String(repeating: " ", count: 3) + String(i)
            } else {
              compactLine += spaces + String(i)
            }
          }
          i += 5
        }
        
        // Handle the final number
        if width % 5 != 0 {
          let lastNumberString = String(width)
          let spacesNeeded = width - compactLine.count - lastNumberString.count
          if spacesNeeded > 0 {
            compactLine += String(repeating: " ", count: spacesNeeded) + lastNumberString
          } else {
            // If we've overshot, trim the line and add the last number
            compactLine = String(compactLine.prefix(width - lastNumberString.count)) + lastNumberString
          }
        }
        result.appendString(compactLine)
        result.addNewLine()
        result.appendString(
          String.repeating(
            ".",
            alternating: "|",
            every: 5,
            totalCount: width
          )
        )
        result.addNewLine()
    }
    
    
    result.setAttributes(container(for: .tertiary))
    return result
  }

}
