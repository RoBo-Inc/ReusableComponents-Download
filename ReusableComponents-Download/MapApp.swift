import AppFeature
import SwiftUI

@main
struct MapApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CityMapsView(
                    store: .init(initialState: .init(.mocks)) {
                        CityMaps()
                            ._printChanges()
                    }
                )
            }
        }
    }
}
