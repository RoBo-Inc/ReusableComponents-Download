import ComposableArchitecture
import ReusableComponents
import SwiftUI

@Reducer
public struct CityMapFeature {
    @ObservableState
    public struct State: Identifiable, Sendable {
        public let id: UUID
        let cityMap: CityMap
        var downloadComponent: DownloadComponent.State
        
        init(cityMap: CityMap) {
            @Dependency(\.uuid) var uuid
            id = uuid()
            self.cityMap = cityMap
            downloadComponent = .init(id: .init(id), url: cityMap.url)
        }
    }
    
    public enum Action: Sendable {
        case downloadComponent(DownloadComponent.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Scope(state: \.downloadComponent, action: \.downloadComponent) {
            DownloadComponent()
        }
        Reduce { state, action in
            switch action {
            case .downloadComponent(.download(.completeEvent)):
                // NB: This is where you could perform the effect to save the data to a file on disk.
                return .none
                
            case .downloadComponent(.alert(.presented(.deleteButtonTapped))):
                // NB: This is where you could perform the effect to delete the data from disk.
                return .none
                
            case .downloadComponent:
                return .none
            }
        }
    }
}

struct CityMapDetailView: View {
    let store: StoreOf<CityMapFeature>
    
    var body: some View {
        Form {
            Text(store.cityMap.blurb)
            HStack {
                switch store.downloadComponent.status {
                case .notDownloaded:
                    Text("Download for offline viewing")
                case .starting:
                    Text("Downloading…")
                case .downloading(let progress):
                    Text("Downloading \(progress)%")
                case .complete:
                    Text("Downloaded")
                }
                Spacer()
                DownloadComponentView(
                    store: store.scope(state: \.downloadComponent, action: \.downloadComponent)
                )
            }
        }
        .navigationTitle(store.cityMap.title)
    }
}

#Preview("Detail") {
    NavigationView {
        CityMapDetailView(
            store: .init(initialState: IdentifiedArrayOf<CityMapFeature.State>.mocks[0]) {}
        )
    }
}
