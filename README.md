# ReusableComponents-Download

### This repo is an in-depth exploration of the corresponding TCA [CaseStudy](https://github.com/pointfreeco/swift-composable-architecture/tree/main/Examples/CaseStudies/SwiftUICaseStudies/05-HigherOrderReducers-ResuableOfflineDownloads).  

## Details
We have a DownloadComponent in both `CityMapRowView` and `CityMapDetailView`. Thus the CaseStudy provides a simple yet effective codebase to explore ways to synchronize the component across two different views.

## Structure
There are two main ways to implement drill-down for tree-based navigation in SwiftUI:
1. Using `NavigationLink`
2. Without `NavigationLink`, by using an additional optional stored property (which can also facilitate deep linking).

It appears that, internally in SwiftUI, these two approaches work in very different ways:
- In the `NavigationLink` approach, the same `cityMap` store (literally the same object with the same `ObjectIdentifier`) is passed to both views: `CityMapRowView` and `CityMapDetailView`.
- In the non-`NavigationLink` approach, it is also the same `cityMap` store, but different objects (with different `ObjectIdentifiers`).

The initial CaseStudy was implemented using the first approach. That's why the DownloadComponent appears to be synchronized without any additional effort (because it is literally the same object).
This initial implementation, with minor code changes and adjustments, corresponds to the commit tagged `1.0.0` in this repo and will be our starting point.

Next, we will explore the second approach (with two different variations):
- Commit tagged `2.0.0`: DownloadComponent is synchronized manually
- Commit tagged `3.0.0`: DownloadComponent is synchronized via `@Shared` state

Only three files will be modified throughout our journey:
1. `Core/CityMaps.swift`
2. `Core/CityMapRow.swift`
3. `Core/CityMapDetail.swift`  

I think it would be convenient to study the code changes by simply comparing the commits.

## Note
I've used the advanced technique recommended in the [Performance section of the TCA documentation](https://pointfreeco.github.io/swift-composable-architecture/main/documentation/composablearchitecture/performance). So the code might look a little less scary if we simply send some more plain actions instead.  
And, of course, I've also used the awesome modularization technique for the overall structure 😊  
Also, the DownloadComponent itself has been separated into a standalone repo (as the whole purpose was to make it reusable in the first place).  

Any feedback and suggestions are highly appreciated. Thank you.
