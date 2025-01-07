import ComposableArchitecture
import ReusableComponents
import SwiftUI

struct CityMapRowView: View {
    let store: StoreOf<CityMapFeature>
    
    var body: some View {
        NavigationLink(
            destination: CityMapDetailView(store: store)
        ) {
            HStack {
                Image(systemName: "map")
                Text(store.cityMap.title)
                Spacer()
                DownloadComponentView(
                    store: store.scope(state: \.downloadComponent, action: \.downloadComponent)
                )
            }
        }
    }
}

#Preview("Row") {
    NavigationView {
        CityMapRowView(
            store: .init(initialState: IdentifiedArrayOf<CityMapRow.State>.mocks[0]) {}
        )
    }
}
