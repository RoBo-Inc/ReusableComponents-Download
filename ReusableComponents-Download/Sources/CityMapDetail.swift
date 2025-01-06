import ComposableArchitecture
import SwiftUI

@Reducer
struct CityMap {
  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    let download: Download
    var downloadComponent: DownloadComponent.State
    
    init(download: Download) {
      id = download.id
      self.download = download
      downloadComponent = DownloadComponent.State(
        id: .init(id),
        url: download.downloadVideoUrl
      )
    }
  }
  
  enum Action {
    case downloadComponent(DownloadComponent.Action)
  }
  
  var body: some Reducer<State, Action> {
    Scope(state: \.downloadComponent, action: \.downloadComponent) {
      DownloadComponent()
    }
    
    Reduce { state, action in
      switch action {
      case .downloadComponent(.downloadClient(.success(.response))):
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
  let store: StoreOf<CityMap>
  
  var body: some View {
    Form {
      Text(store.download.blurb)
      
      HStack {
        switch store.downloadComponent.mode {
        case .notDownloaded:
          Text("Download for offline viewing")
        case .downloaded:
          Text("Downloaded")
        case .downloading(let progress):
          Text("Downloading \(Int(100 * progress))%")
        case .startingToDownload:
          Text("Downloading…")
        }
        
        Spacer()
        
        DownloadComponentView(
          store: store.scope(state: \.downloadComponent, action: \.downloadComponent)
        )
      }
    }
    .navigationTitle(store.download.title)
  }
}

#Preview("Detail") {
  NavigationView {
    CityMapDetailView(
      store: .init(initialState: IdentifiedArrayOf<CityMap.State>.mocks[0]) {}
    )
  }
}
