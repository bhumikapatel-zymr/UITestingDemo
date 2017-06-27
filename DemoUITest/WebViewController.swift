//
//  WebViewController.swift
//  DemoUITest
//
//  Created by Bhumika Patel on 22/06/17.
//  Copyright © 2017 Bhumika Patel. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        installWebView()

        guard let url = URL(string: "https://en.wikipedia.org/wiki/Team") else { return }

        let request = URLRequest(url: url)
        webView.load(request)
    }

    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    private func installWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: [ "view": webView ]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: [ "view": webView ]))
    }
}
