import ComposableArchitecture
import SwiftUI

private let readMe = """
  This screen demonstrates how one can create reusable components in the Composable Architecture.
  
  The "download component" is a component that can be added to any view to enhance it with the \
  concept of downloading offline content. It facilitates downloading the data, displaying a \
  progress view while downloading, canceling an active download, and deleting previously \
  downloaded data.
  
  Tap the download icon to start a download, and tap again to cancel an in-flight download or to \
  remove a finished download. While a file is downloading you can tap a row to go to another \
  screen to see that the state is carried over.
  """

@Reducer
struct MapApp {
  @ObservableState
  struct State: Equatable {
    var cityMaps: IdentifiedArrayOf<CityMap.State> = .mocks
  }
  
  enum Action {
    case cityMaps(IdentifiedActionOf<CityMap>)
  }
  
  var body: some Reducer<State, Action> {
    EmptyReducer().forEach(\.cityMaps, action: \.cityMaps) {
      CityMap()
    }
  }
}

struct CitiesView: View {
  let store: StoreOf<MapApp>
  
  var body: some View {
    Form {
      Section {
        AboutView(readMe: readMe)
      }
      ForEach(store.scope(state: \.cityMaps, action: \.cityMaps)) { cityMapStore in
        CityMapRowView(store: cityMapStore)
      }
    }
    .navigationTitle("Offline Downloads")
  }
}

#Preview("List") {
  NavigationStack {
    CitiesView(
      store: .init(initialState: .init(cityMaps: .mocks)) {
        MapApp()
      }
    )
  }
}
