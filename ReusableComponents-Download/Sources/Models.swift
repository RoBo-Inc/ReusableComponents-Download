import Foundation

struct Download: Equatable, Identifiable {
  let blurb: String
  let downloadVideoUrl: URL
  let id: UUID
  let title: String
}
