//
//  ProfileViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/20/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit


class ProfileViewController: ViewController {
 
    @IBOutlet weak var currentUserImg: UIImageView!
    @IBOutlet weak var bitmojiOne: UIImageView!
    @IBOutlet weak var bitmojiTwo: UIImageView!
    @IBOutlet weak var bitmojiThree: UIImageView!
    @IBOutlet weak var bitmojiFour: UIImageView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

    }
    
    override func setUpElements() {
       makeRounded(currentUserImg)
        altRound(bitmojiOne)
        altRound(bitmojiTwo)
        altRound(bitmojiThree)
        altRound(bitmojiFour)
    }

    
    func makeRounded(_ image: UIImageView) {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
    }
    
    func altRound(_ image: UIImageView) {
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.bounds.width / 2
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
