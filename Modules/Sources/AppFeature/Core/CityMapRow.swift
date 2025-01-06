import ComposableArchitecture
import ReusableComponents
import SwiftUI

struct CityMapRowView: View {
  let store: StoreOf<CityMap>
  
  var body: some View {
    NavigationLink(
      destination: CityMapDetailView(store: store)
    ) {
      HStack {
        Image(systemName: "map")
        Text(store.download.title)
        Spacer()
        DownloadComponentView(
          store: store.scope(state: \.downloadComponent, action: \.downloadComponent)
        )
      }
    }
  }
}
