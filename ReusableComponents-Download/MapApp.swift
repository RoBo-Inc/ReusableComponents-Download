import AppFeature
import SwiftUI

@main
struct MapApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        CitiesView(
          store: .init(initialState: .init(.mocks)) {
            Cities()
              ._printChanges()
          }
        )
      }
    }
  }
}
