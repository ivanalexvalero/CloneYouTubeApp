//
//  HomePresenter.swift
//  CloneYouTubeApp
//
//  Created by Ivan Valero on 18/03/2022.
//

import Foundation

protocol HomerViewProtocol: AnyObject {
    func getData(list: [[Any]])
}

class MockManager{
    static var shared = MockManager()
    var runAppWhithMock: Bool = true
}

class HomePresenter {
    var provider: HomeProviderProtocol
    weak var delegate: HomerViewProtocol?
    private var objectList : [[Any]] = []
    
    
    init(delegate: HomerViewProtocol, provider: HomeProviderProtocol = HomeProvider()) {
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppWhithMock{
            self.provider = HomeProviderMock()
        }
        #endif
    }
    
    func getHomeObjects() async{
        objectList.removeAll()
        
        async let channel = try await provider.getChannel(channelId: Constants.channelId).items
        async let playlist = try await provider.getPlayLists(channelId: Constants.channelId).items
        async let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
        
//            async let playlistItems = try await provider.getPlayListItems(playlistId: playlist.first?.id ?? "").items
        
        do{

            let (responseChannel, responsePlaylist, responseVideos) = await (try channel, try playlist, try videos)
    
            // Index 0
            objectList.append(responseChannel)
            
            if let playlistId = responsePlaylist.first?.id, let playlistItems = await getPlaylistItems(playlistId: playlistId){
                // Index 1
                objectList.append(playlistItems.items)
            }
            // Index 2
            objectList.append(responseVideos)
            // Index 3
            objectList.append(responsePlaylist)
            
            delegate?.getData(list: objectList)
            
        } catch {
            print(error)
        }
    }
    
    func getPlaylistItems(playlistId: String) async -> PlaylistItemsModel?{
        
        do{
            let playlistItems = try await provider.getPlayListItems(playlistId: playlistId)
            return playlistItems
        }catch{
            print("error:", error)
            return nil
        }
        
    }
    
}
