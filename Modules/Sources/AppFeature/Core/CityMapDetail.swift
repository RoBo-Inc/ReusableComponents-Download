import ComposableArchitecture
import ReusableComponents
import SwiftUI

@Reducer
public struct CityMapDetail {
    @ObservableState
    public struct State: Sendable {
        let id: UUID
        let cityMap: CityMap
        var downloadComponent: DownloadComponent.State
        
        init(_ cityMapRow: CityMapRow.State) {
            id = cityMapRow.id
            self.cityMap = cityMapRow.cityMap
            downloadComponent = cityMapRow.downloadComponent
        }
    }
    
    public enum Action: Sendable {
        case downloadComponent(DownloadComponent.Action)
    }
}

struct CityMapDetailView: View {
    let store: StoreOf<CityMapDetail>
    
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
            store: .init(initialState: .init(IdentifiedArrayOf<CityMapRow.State>.mocks[0])) {}
        )
    }
}
