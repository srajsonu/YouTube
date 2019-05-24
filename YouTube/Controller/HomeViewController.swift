//
//  ViewController.swift
//  YouTube
//
//  Created by ARY@N on 18/05/19.
//  Copyright © 2019 ARYAN. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    //collection of videos
//    var videos: [video] = {
//
//        var kaneyChannel = Channel()
//        kaneyChannel.name = "kaneyChannelIsBest"
//        kaneyChannel.prifileImageViewName = "kanye"
//
//        var blankSpaceVideo = video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor"
//        blankSpaceVideo.channel = kaneyChannel
//        blankSpaceVideo.numberOfViews = 46565464
//
//        var badBloodVideo = video()
//        badBloodVideo.title = "Tylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.thumbnailImageName = "bad_blood"
//        badBloodVideo.channel = kaneyChannel
//        badBloodVideo.numberOfViews = 45664646466
//
//        return [blankSpaceVideo,badBloodVideo]
//    }()
    
    var videos :[video]?
    
    func fetchVideos(){
        
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        let request = URLRequest(url: url! as URL)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil{
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [video]()
                
                for dict in json as! [[String : AnyObject]] {
                    let Video = video()
                    Video.title = dict["title"] as? String
                    Video.thumbnailImageName = dict["thumbnail_image_name"] as? String
                    
                    let channelDict = dict["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDict["name"] as? String
                    channel.prifileImageViewName = channelDict["profile_image_name"] as? String
                    Video.channel = channel
                    self.videos?.append(Video)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        navigationController?.navigationBar.isTranslucent = false//for darker red
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))//change the position of navigation title
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        collectionView.register(videoCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)//pull down the collection view
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        setupMenuBar()
        setupNavBarButton()
    }
    
    //search & more navbar button
    func setupNavBarButton(){
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton,searchBarButtonItem]
    }
    @objc func handleMore(){
        print(345)
    }
    @objc func handleSearch(){
        print(123)
    }
    let MenuBar: menuBar = {
        let mb = menuBar()
        return mb
    }()
    private func setupMenuBar(){
        view.addSubview(MenuBar)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: MenuBar)
        view.addConstrainsWithFormat(format: "V:|[v0(50)]", views: MenuBar)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! videoCell //cell return as video cell
        
        cell.video = videos?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let height = (view.frame.width-16)*9/16
        return CGSize(width: view.frame.width,height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

