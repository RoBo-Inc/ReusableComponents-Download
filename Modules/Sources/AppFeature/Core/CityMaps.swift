import ComposableArchitecture
import ReusableComponents
import SwiftUI

@Reducer
public struct CityMaps: Sendable {
    @ObservableState
    public struct State: Sendable {
        var cityMapRows: IdentifiedArrayOf<CityMapRow.State>
        @Presents var cityMapDetail: CityMapDetail.State?
        
        public init(_ cityMapRows: IdentifiedArrayOf<CityMapRow.State>) {
            self.cityMapRows = cityMapRows
        }
    }
    
    public enum Action: Sendable {
        case cityMapTapped(CityMapRow.State)
        case cityMapRows(IdentifiedActionOf<CityMapRow>)
        case cityMapDetail(PresentationAction<CityMapDetail.Action>)
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .cityMapTapped(let cityMapRow):
                state.cityMapDetail = .init(cityMapRow)
                return .none
            case let .cityMapRows(.element(id: id, action: .downloadComponent(action))):
                return rowComponent(&state, id: id, action: action)
            case .cityMapDetail(.presented(.downloadComponent(let action))):
                guard let id = state.cityMapDetail?.id else { return .none }
                return rowComponent(&state, id: id, action: action)
            case .cityMapDetail(.dismiss):
                return .none
            }
        }
        .ifLet(\.$cityMapDetail, action: \.cityMapDetail) {
            CityMapDetail()
        }
    }
    
    private func rowComponent(_ state: inout State, id: UUID, action: DownloadComponent.Action) -> Effect<Action> {
        guard var rowComponent = state.cityMapRows[id: id]?.downloadComponent else { return .none }
        defer {
            state.cityMapRows[id: id]?.downloadComponent = rowComponent
            if state.cityMapDetail?.id == id {
                state.cityMapDetail?.downloadComponent = rowComponent
            }
        }
        return DownloadComponent()
            .dependency(\.urlSession, .init(configuration: .ephemeral))
            .reduce(into: &rowComponent, action: action)
            .map { Action.cityMapRows(.element(id: id, action: .downloadComponent($0))) }
    }
}

public struct CityMapsView: View {
    @Bindable var store: StoreOf<CityMaps>
    
    public init(store: StoreOf<CityMaps>) {
        self.store = store
    }
    
    public var body: some View {
        Form {
            Section {
                AboutView(readMe: readMe)
            }
            ForEach(store.scope(state: \.cityMapRows, action: \.cityMapRows)) { cityMapRow in
                Button {
                    store.send(.cityMapTapped(cityMapRow.state))
                } label: {
                    CityMapRowView(store: cityMapRow)
                }
            }
        }
        .navigationTitle("Offline Downloads")
        .navigationDestination(
            item: $store.scope(state: \.cityMapDetail, action: \.cityMapDetail),
            destination: CityMapDetailView.init
        )
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
