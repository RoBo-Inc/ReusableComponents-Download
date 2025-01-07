import ComposableArchitecture
import ReusableComponents
import SwiftUI

@Reducer
public struct CityMapRow {
    @ObservableState
    public struct State: Identifiable, Sendable {
        public let id: UUID
        let cityMap: CityMap
        @Shared var downloadComponent: DownloadComponent.State
        
        init(cityMap: CityMap) {
            @Dependency(\.uuid) var uuid
            id = uuid()
            self.cityMap = cityMap
            _downloadComponent = .init(value: .init(id: .init(id), url: cityMap.url))
        }
    }
    
    public enum Action: Sendable {
        case downloadComponent(DownloadComponent.Action)
    }
}


struct CityMapRowView: View {
    let store: StoreOf<CityMapRow>
    
    var body: some View {
        HStack {
            Image(systemName: "map")
            Text(store.cityMap.title)
            Spacer()
            DownloadComponentView(
                store: store.scope(state: \.downloadComponent, action: \.downloadComponent)
            )
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary.opacity(0.5))
                .font(.system(size: 14))
        }
        .foregroundColor(.primary)
    }
}

#Preview("Row") {
    NavigationView {
        CityMapRowView(
            store: .init(initialState: IdentifiedArrayOf<CityMapRow.State>.mocks[0]) {}
        )
    }
}
