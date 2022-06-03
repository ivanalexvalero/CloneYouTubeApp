//
//  HomeProviderMock.swift
//  CloneYouTubeApp
//
//  Created by Ivan Valero on 01/06/2022.
//

import Foundation

class HomeProviderMock: HomeProviderProtocol{
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel {
        guard let model = Utils.dataJson(jsonName: "SearchVideos", model: VideoModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getChannel(channelId: String) async throws -> ChannelsModel {
        guard let model = Utils.dataJson(jsonName: "Channel", model: ChannelsModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getPlayLists(channelId: String) async throws -> PlaylistModel {
        guard let model = Utils.dataJson(jsonName: "Playlist", model: PlaylistModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getPlayListItems(playlistId: String) async throws -> PlaylistItemsModel {
        guard let model = Utils.dataJson(jsonName: "PlaylistItems", model: PlaylistItemsModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    
}
