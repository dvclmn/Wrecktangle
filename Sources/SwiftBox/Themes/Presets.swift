//
//  Presets.swift
//  SwiftBox
//
//  Created by Dave Coleman on 24/8/2024.
//

import SwiftUI
import BaseStyles

public extension SwiftBox.Theme.ColourSet {
  
  ///
  /// ```swift
  /// let defaultColorSet = ColorSet.default
  /// let purpleColorSet = ColorSet.purple
  /// let matrixColorSet = ColorSet.matrix
  /// ```
  static let `default`: Self = Self(
    primary: Color.primary,
    secondary: Color.chalkBlue,
    tertiary: Color.tertiary,
    accent: Color.peach
  )
  
  static let purple: Self = Self(
    primary: Color.lavendar,
    secondary: Color.secondary,
    tertiary: Color.tertiary,
    accent: Color.peach
  )
  
  static let matrix: Self = Self(
    primary: Color.green,
    secondary: Color.secondary,
    tertiary: Color.tertiary,
    accent: Color.olive
  )
  
}

public extension Color {
  static let primary = Color.primary
  static let secondary = Color.secondary
  static let tertiary = Color.secondary.opacity(0.4)
  static let peach = Swatch.peach.colour
  static let lavendar = Swatch.lavendar.colour
  static let olive = Swatch.olive.colour
  static let chalkBlue = Swatch.chalkBlue.colour
  static let slate = Swatch.slate.colour
  static let green = Color.green
}
