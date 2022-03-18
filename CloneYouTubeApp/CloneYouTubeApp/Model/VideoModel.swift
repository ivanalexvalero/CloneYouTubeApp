//
//  VideoModel.swift
//  CloneYouTubeApp
//
//  Created by Ivan Valero on 17/03/2022.
//

import Foundation

// MARK: - VideoModel
struct VideoModel: Decodable {
    let kind, etag: String
    let items: [Item]
    let pageInfo: PageInfo
    
    // MARK: - PageInfo
    struct PageInfo: Decodable {
        let totalResults, resultsPerPage: Int
    }
    
    // MARK: - Item
    struct Item: Decodable {
        let kind, etag, id: String
        let snippet: Snippet
        let contentDetails: ContentDetails
        let status: Status
        let statistics: Statistics
        let topicDetails: TopicDetails
        
        // MARK: - Snippet
        struct Snippet: Decodable {
            let publishedAt: Date
            let channelId, title, description: String
            let thumbnails: Thumbnails
            let channelTitle: String
            let tags: [String]
            let categoryId, liveBroadcastContent: String
            let localized: Localized
            let defaultAudioLanguage: String

            enum CodingKeys: String, CodingKey {
                case publishedAt
                case channelId
                case title
                case description
                case thumbnails, channelTitle, tags
                case categoryId
                case liveBroadcastContent, localized, defaultAudioLanguage
            }
            
            // MARK: - Localized
            struct Localized: Decodable {
                let title, localizedDescription: String

                enum CodingKeys: String, CodingKey {
                    case title
                    case localizedDescription = "description"
                }
            }
            
            // MARK: - Thumbnails
            struct Thumbnails: Decodable {
                let thumbnailsDefault, medium, high: Default

                enum CodingKeys: String, CodingKey {
                    case thumbnailsDefault = "default"
                    case medium, high
                }
                
                // MARK: - Default
                struct Default: Decodable {
                    let url: String
                    let width, height: Int
                }
            }
        }//Snippet
        
        // MARK: - ContentDetails
        struct ContentDetails: Decodable {
            let duration, dimension, definition, caption: String
            let licensedContent: Bool
            let projection: String
        }
        
        // MARK: - Statistics
        struct Statistics: Decodable {
            let viewCount, likeCount, favoriteCount, commentCount: String
        }

        // MARK: - Status
        struct Status: Decodable {
            let uploadStatus, privacyStatus, license: String
            let embeddable, publicStatsViewable, madeForKids: Bool
        }

        // MARK: - TopicDetails
        struct TopicDetails: Decodable {
            let topicCategories: [String]
        }
    }//Item
}
