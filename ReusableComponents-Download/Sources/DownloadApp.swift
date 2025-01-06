import SwiftUI

@main
struct DownloadApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        CitiesView(
          store: .init(initialState: .init(cityMaps: .mocks)) {
            MapApp()
              ._printChanges()
          }
        )
      }
    }
  }
}
