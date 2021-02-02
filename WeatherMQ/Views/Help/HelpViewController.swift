//
//  HelpViewController.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 02/02/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []

        let player = WKWebView(frame: .zero, configuration: webConfiguration)
        self.view.addSubview(player)
        player.topAnchor(equalTo: self.view.topAnchor, constant: 44)
        player.bottomAnchor(equalTo: self.view.bottomAnchor, constant: 44)

        player.leadingAnchor(equalTo: self.view.leadingAnchor, constant: 0)
        player.trailingAnchor(equalTo: self.view.trailingAnchor, constant: 0)

        guard let path = Bundle.main.path(forResource: "How_to", ofType: "mov") else {
            return
        }
        guard let url = URL(string: "file:/" + path) else {
            return
        }
        let request: URLRequest = URLRequest(url: url)
        player.load(request)

    }
}
