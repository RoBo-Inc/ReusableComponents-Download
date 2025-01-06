import ComposableArchitecture
import SwiftUI

@Reducer
public struct Cities: Sendable {
  @ObservableState
  public struct State: Sendable {
    var cityMaps: IdentifiedArrayOf<CityMap.State>
    
    public init(_ cityMaps: IdentifiedArrayOf<CityMap.State>) {
      self.cityMaps = cityMaps
    }
  }
  
  public enum Action: Sendable {
    case cityMaps(IdentifiedActionOf<CityMap>)
  }
  
  public init() {}
  
  public var body: some Reducer<State, Action> {
    EmptyReducer().forEach(\.cityMaps, action: \.cityMaps) {
      CityMap()
    }
  }
}

public struct CitiesView: View {
  let store: StoreOf<Cities>
  
  public init(store: StoreOf<Cities>) {
    self.store = store
  }
  
  public var body: some View {
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
      store: .init(initialState: .init(.mocks)) {
        Cities()
      }
    )
  }
}
