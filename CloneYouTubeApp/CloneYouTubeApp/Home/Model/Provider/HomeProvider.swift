//
//  HomeProvider.swift
//  CloneYouTubeApp
//
//  Created by Ivan Valero on 18/03/2022.
//

import Foundation

protocol HomeProviderProtocol {
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel
    func getChannel(channelId: String) async throws -> ChannelsModel
    func getPlayLists(channelId: String) async throws -> PlaylistModel
    func getPlayListItems(playlistId: String) async throws -> PlaylistItemsModel
}
class HomeProvider: HomeProviderProtocol {
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel {
        var queryParams: [String:String] = ["part":"snippet", "type":"video"]
        if !channelId.isEmpty{
            queryParams["channelId"] = channelId
        }
        if !searchString.isEmpty{
            queryParams["q"] = searchString
        }
        let requestModel = RequestModel(endpoint: .search, queryItems: queryParams)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, VideoModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    func getChannel(channelId: String) async throws -> ChannelsModel {
        let queryParams: [String:String] = ["part":"snippet,statistics,brandingSettings",
                                            "id": channelId]

        let requestModel = RequestModel(endpoint: .channels, queryItems: queryParams)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, ChannelsModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    func getPlayLists(channelId: String) async throws -> PlaylistModel {
        let queryParams: [String:String] = ["part":"snippet,contentDetails",
                                            "channelId":channelId]
        
        let requestModel = RequestModel(endpoint: .playlists, queryItems: queryParams)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, PlaylistModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    func getPlayListItems(playlistId: String) async throws -> PlaylistItemsModel {
        let queryParams: [String:String] = ["part":"snippet,id,contentDetails",
                                            "playlistId":playlistId]
        
        let requestModel = RequestModel(endpoint: .playlistItems, queryItems: queryParams)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, PlaylistItemsModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
}
    
