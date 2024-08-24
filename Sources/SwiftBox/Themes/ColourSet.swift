//
//  ColourSet.swift
//  SwiftBox
//
//  Created by Dave Coleman on 24/8/2024.
//

import SwiftUI
import IdentifiedCollections
import BaseStyles

extension SwiftBox.Theme {
  
  public struct ColourSet {
    private var colors: IdentifiedArrayOf<Attributes>
    
    public init(
      primary: Color,
      secondary: Color,
      tertiary: Color,
      accent: Color
    ) {
      self.colors = IdentifiedArrayOf<Attributes>(uniqueElements: [
        Attributes(id: .primary, foreground: primary),
        Attributes(id: .secondary, foreground: secondary),
        Attributes(id: .tertiary, foreground: tertiary),
        Attributes(id: .accent, foreground: accent)
      ])
    }
    
    /// `subscript` is a shorthand way to access elements in a collection.
    /// It allows the use of square bracket notation `[]` to get or set values.
    /// Further reading: `https://docs.swift.org/swift-book/documentation/the-swift-programming-language/subscripts/`
    ///
    /// In our case, it allows us to access `Attributes` objects using `ColorCategory` as an index. For example:
    ///
    /// ```swift
    /// let primaryColor = myColourSet[.primary]
    /// ```
    ///
    public subscript(category: ColourCategory) -> Attributes {
      get { colors[id: category] ?? Attributes(id: category, foreground: .black) }
      set { colors[id: category] = newValue }
    }
    
    public mutating func updateColor(for category: ColourCategory, foreground: Color, background: Color? = nil) {
      colors[id: category]?.foreground = foreground
      colors[id: category]?.background = background
    }
    
    /// This method provides an alternative way to retrieve a `Attributes` for a given
    /// category. While it's similar to the `subscript`, it has some advantages:
    ///
    /// - It's more explicit in its intent, which can make code more readable.
    /// - It can be easier to use in certain contexts, like when passing as a closure.
    /// - It allows for more complex logic or error handling if needed in the future.
    ///
    /// Usage example:
    ///
    /// ```swift
    /// let secondaryColor = myColourSet.color(for: .secondary)
    /// ```
    ///
    public func color(for category: ColourCategory) -> Attributes {
      colors[id: category] ?? Attributes(id: category, foreground: .black)
    }
  }
  
  public enum ColourCategory: String, Identifiable {
    case primary    /// Text
    case secondary  /// Box frame
    case tertiary   /// Invisibles
    case accent     /// Subtle accents
    
    public var id: String {
      self.rawValue
    }
  }
  
  /// `AttributeSet` holds an `AttributeContainer` instance, which
  /// holds all the styles for the set.
  ///
  /// I find `AttributeContainer`s somewhat clumsy to make, so this type
  /// abstracts this job away from the user. Also, `SwiftBox` (currently) only
  /// really needs foreground/background colours, so having `AttributeSet`
  /// makes that more accesible/straightforward.
  ///
  /// We can rely on the computed property `container` to return an *actual*
  /// container when we need it.
  ///
  public struct Attributes: Identifiable {
    public let id: ColourCategory
    var foreground: Color
    var background: Color?
    
    init(id: ColourCategory, foreground: Color, background: Color? = nil) {
      self.id = id
      self.foreground = foreground
      self.background = background
    }
    
    var container: AttributeContainer {
      var attrContainer = AttributeContainer()
      attrContainer.foregroundColor = self.foreground
      attrContainer.backgroundColor = self.background
      return attrContainer
    }
  }
  
  
  
  

  
}
