import ComposableArchitecture
import SwiftUI

@Reducer
public struct CityMaps: Sendable {
    @ObservableState
    public struct State: Sendable {
        var cityMapRows: IdentifiedArrayOf<CityMapFeature.State>
        
        public init(_ cityMapRows: IdentifiedArrayOf<CityMapFeature.State>) {
            self.cityMapRows = cityMapRows
        }
    }
    
    public enum Action: Sendable {
        case cityMapRows(IdentifiedActionOf<CityMapFeature>)
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        EmptyReducer().forEach(\.cityMapRows, action: \.cityMapRows) {
            CityMapFeature()
        }
    }
}

public struct CityMapsView: View {
    let store: StoreOf<CityMaps>
    
    public init(store: StoreOf<CityMaps>) {
        self.store = store
    }
    
    public var body: some View {
        Form {
            Section {
                AboutView(readMe: readMe)
            }
            ForEach(store.scope(state: \.cityMapRows, action: \.cityMapRows)) { cityMapRow in
                CityMapRowView(store: cityMapRow)
            }
        }
        .navigationTitle("Offline Downloads")
    }
}

#Preview("List") {
    NavigationStack {
        CityMapsView(
            store: .init(initialState: .init(.mocks)) {
                CityMaps()
            }
        )
    }
}
