//
//  ViewController.swift
//  LoginProject
//
//  Created by Gadgetzone on 27/06/21.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var video: AVPlayer?
    var videoLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
    }
    
    func setupVideo() {
        
        guard let path = Bundle.main.path(forResource: "backgroundVideo", ofType: "mp4") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        let item = AVPlayerItem(url: url)
        
        video = AVPlayer(playerItem: item)
        
        videoLayer = AVPlayerLayer(player: video!)
        
        videoLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoLayer!, at: 0)
        
        video?.playImmediately(atRate: 0.5)
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
    }
    
}

