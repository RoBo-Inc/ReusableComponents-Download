import ComposableArchitecture
import Foundation

public extension IdentifiedArray where ID == CityMap.State.ID, Element == CityMap.State {
  static let mocks: Self = [
    .init(
      download: .init(
        downloadVideoUrl: .init(string: "http://ipv4.download.thinkbroadband.com/50MB.zip")!,
        title: "New York, NY",
        blurb: """
          New York City (NYC), known colloquially as New York (NY) and officially as the City of \
          New York, is the most populous city in the United States. With an estimated 2018 \
          population of 8,398,748 distributed over about 302.6 square miles (784 km2), New York \
          is also the most densely populated major city in the United States.
          """
      )
    ),
    .init(
      download: .init(
        downloadVideoUrl: .init(string: "http://ipv4.download.thinkbroadband.com/50MB.zip")!,
        title: "Los Angeles, LA",
        blurb: """
          Los Angeles, officially the City of Los Angeles and often known by its initials L.A., \
          is the largest city in the U.S. state of California. With an estimated population of \
          nearly four million people, it is the country's second most populous city (after New \
          York City) and the third most populous city in North America (after Mexico City and \
          New York City). Los Angeles is known for its Mediterranean climate, ethnic diversity, \
          Hollywood entertainment industry, and its sprawling metropolis.
          """
      )
    ),
    .init(
      download: .init(
        downloadVideoUrl: .init(string: "http://ipv4.download.thinkbroadband.com/50MB.zip")!,
        title: "Paris, France",
        blurb: """
          Paris is the capital and most populous city of France, with a population of 2,148,271 \
          residents (official estimate, 1 January 2020) in an area of 105 square kilometres (41 \
          square miles). Since the 17th century, Paris has been one of Europe's major centres of \
          finance, diplomacy, commerce, fashion, science and arts.
          """
      )
    ),
    .init(
      download: .init(
        downloadVideoUrl: .init(string: "http://ipv4.download.thinkbroadband.com/50MB.zip")!,
        title: "Tokyo, Japan",
        blurb: """
          Tokyo, officially Tokyo Metropolis (東京都, Tōkyō-to), is the capital of Japan and the \
          most populous of the country's 47 prefectures. Located at the head of Tokyo Bay, the \
          prefecture forms part of the Kantō region on the central Pacific coast of Japan's main \
          island, Honshu. Tokyo is the political, economic, and cultural center of Japan, and \
          houses the seat of the Emperor and the national government.
          """
      )
    ),
    .init(
      download: .init(
        downloadVideoUrl: .init(string: "http://ipv4.download.thinkbroadband.com/50MB.zip")!,
        title: "Buenos Aires, Argentina",
        blurb: """
          Buenos Aires is the capital and largest city of Argentina. The city is located on the \
          western shore of the estuary of the Río de la Plata, on the South American continent's \
          southeastern coast. "Buenos Aires" can be translated as "fair winds" or "good airs", \
          but the former was the meaning intended by the founders in the 16th century, by the \
          use of the original name "Real de Nuestra Señora Santa María del Buen Ayre", named \
          after the Madonna of Bonaria in Sardinia.
          """
      )
    ),
  ]
}
