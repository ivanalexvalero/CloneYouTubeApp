//
//  PlaylistItems.swift
//  CloneYouTubeApp
//
//  Created by Ivan Valero on 17/03/2022.
//

import Foundation

// MARK: - PlaylistItems
struct PlaylistItemsModel: Decodable {
    let kind: String
    let etag: String
    let items: [Item]
    let pageInfo: PageInfo
    
    struct Item: Decodable {
        let kind : String
               let etag : String
               let id : String
               let snippet : VideoModel.Item.Snippet
    }
    
    // MARK: - PageInfo
    struct PageInfo: Decodable {
        let totalResults: Int
        let resultsPerPage: Int
    }
    
}
