import ComposableArchitecture
import ReusableComponents
import SwiftUI

@Reducer
public struct CityMap {
  @ObservableState
  public struct State: Identifiable, Sendable {
    public let id: UUID
    let download: Download
    var downloadComponent: DownloadComponent.State
    
    init(download: Download) {
      @Dependency(\.uuid) var uuid
      id = uuid()
      self.download = download
      downloadComponent = .init(id: .init(id), url: download.downloadVideoUrl)
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
  let store: StoreOf<CityMap>
  
  var body: some View {
    Form {
      Text(store.download.blurb)
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
