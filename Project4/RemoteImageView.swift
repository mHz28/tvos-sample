//
//  RemoteImageView.swift
//  Project4
//
//  Created by Stephen DeStefano on 5/18/17.
//  Copyright © 2017 Stephen DeStefano. All rights reserved.
//

import UIKit

class RemoteImageView: UIImageView {

    var url: URL?
    
    func getCachesDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func load(_ url: URL) {
        
        //stash the URL away for later checking
        self.url = url
        
        //create a safe-to-save version of this URL that will be our cache filename
        guard let savedFilename = url.absoluteString.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else { return }
        
        //append that to the caches directory to get a complete path
        let fullPath = getCachesDirectory().appendingPathComponent(savedFilename)
        
        //if the cached image exists already
        if FileManager.default.fileExists(atPath: fullPath.path) {
            
            //use it and return
            image = UIImage(contentsOfFile: fullPath.path)
            
            return
        }
        
        //still here? push work to a background thread
        DispatchQueue.global(qos: .userInitiated).async {
            
            //download the image data
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            //write it to our cache file
            try? imageData.write(to: fullPath)
            
            //now the image has downloaded, check it's still the one we want
            if self.url == url {
                
                //push work back to the main thread
                DispatchQueue.main.async {
                    
                    //update our image
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }

}
