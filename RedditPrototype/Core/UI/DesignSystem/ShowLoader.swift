//
//  ShowLoader.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import UIKit
import AVFoundation

class CustomLoader {
    static let shared = CustomLoader() // Singleton para acceder desde cualquier lugar
    
    private let loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.color = .purple
        loader.hidesWhenStopped = true
        return loader
    }()

    func showLoader() {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        loaderView.center = keyWindow.center
        keyWindow.addSubview(loaderView)
        loaderView.startAnimating()
    }

    func hideLoader() {
        loaderView.stopAnimating()
        loaderView.removeFromSuperview()
    }
}

class LoaderVideo: UIView {
    static let shared = LoaderVideo() // Singleton para acceder desde cualquier lugar
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            controlsContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            controlsContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            controlsContainerView.widthAnchor.constraint(equalToConstant: 200), // Ancho del contenedor
            controlsContainerView.heightAnchor.constraint(equalToConstant: 100), // Alto del contenedor
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

