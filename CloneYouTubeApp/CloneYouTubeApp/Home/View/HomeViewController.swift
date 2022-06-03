//
//  HomeViewController.swift
//  CloneYouTubeApp
//
//  Created by Ivan Valero on 18/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    

    @IBOutlet weak var tableViewHome: UITableView!
    lazy var presenter = HomePresenter(delegate: self)
    private var objectList : [[Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await presenter.getHomeObjects()
            
        }
    }

    func configTableView(){
        let nibChannel = UINib(nibName: "\(ChannelCell.self)", bundle: nil)
        tableViewHome.register(nibChannel, forCellReuseIdentifier: "\(ChannelCell.self)")
        
        let nibVideo = UINib(nibName: "\(VideoCell.self)", bundle: nil)
        tableViewHome.register(nibVideo, forCellReuseIdentifier: "\(VideoCell.self)")
        
        let nibPlaylist = UINib(nibName: "\(PlaylistCell.self)", bundle: nil)
        tableViewHome.register(nibPlaylist, forCellReuseIdentifier: "\(PlaylistCell.self)")
        
        tableViewHome.dataSource = self
        tableViewHome.delegate = self
    }

 

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = objectList[indexPath.section]
        if let channel = item as? [ChannelsModel.Item]{
            guard let channelCell = tableView.dequeueReusableCell(withIdentifier: "\(ChannelCell.self)", for: indexPath) as? ChannelCell else{
                return UITableViewCell()
            }
            return channelCell
        }else if let playlistItems = item as? [PlaylistItemsModel.Item]{
            guard let playlistItemsCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else{
                return UITableViewCell()
            }
            return playlistItemsCell
        } else if let videos = item as? [VideoModel.Item]{
            guard let videoCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else{
                return UITableViewCell()
            }
            return videoCell
        }else if let playlist = item as? [PlaylistModel.Item]{
            guard let playlistCell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistCell.self)", for: indexPath) as? PlaylistCell else {
                return UITableViewCell()
            }
            return playlistCell
        }
        
        return UITableViewCell()
    }
}


extension HomeViewController : HomerViewProtocol {
    func getData(list: [[Any]]) {
        objectList = list
        tableViewHome.reloadData()
    }
}
