//
//  ViewController.swift
//  TestApp
//
//  Created by Siddharth on 26/10/16.
//  Copyright © 2016 Cognizant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func createZipFile(_ sender: AnyObject) {
        zipFileData()
    }
    var zipPath: String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func zipFileData(){
        //let ssZip = SSZipArchive()
        let sampleDataPath = Bundle.main.bundleURL.appendingPathComponent("Sample Data").path
        zipPath = tempZipPath()
        print("Zip Path--> \(zipPath)")
        let success = SSZipArchive.createZipFile(atPath: zipPath!, withContentsOfDirectory: sampleDataPath)
        if success {
            print("Zip successfully")
        }
    }
    func tempZipPath() -> String {
        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        path += "/\(UUID().uuidString).zip"
        return path
    }


    @IBAction func unZipFile(_ sender: AnyObject) {
        guard let zipPath = self.zipPath else {
            return
        }
        
        guard let unzipPath = tempUnzipPath() else {
            return
        }
        print("unzipPath --> \(unzipPath)")
        let success = SSZipArchive.unzipFile(atPath: zipPath, toDestination: unzipPath)
        if !success {
            return
        }
    }
    
    func tempUnzipPath() -> String? {
        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        path += "/\(UUID().uuidString)"
        let url = URL(fileURLWithPath: path)
        
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return nil
        }
        
        
        return url.path
    }
}

