//
//  ViewController.swift
//  GCD
//
//  Created by David Svensson on 2021-12-02.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var inactiveQueue : DispatchQueue?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // simpleQueue()
        
       // queuesWithPriority()
//        concurrentQueue()
//        inactiveQueue?.activate()
        
        fetchImage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            print("💜")
        })
        
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        for i in 0...10000000 {
//            print("hej")
//        }
//
//    }
    
    
    func simpleQueue() {
        
        let queue = DispatchQueue(label: "myQueue")
        
        
        queue.async {
            for i in 0...10 {
                print("🍏 \(i) ")
            }
        }
        
        for i in 0...10 {
            print("🍎 \(i)")
        }
    }
    
    func queuesWithPriority() {
        let queue1 = DispatchQueue(label: "queue1", qos: .userInitiated)
        let queue2 = DispatchQueue(label: "queue2", qos: .utility)
        
        queue1.async {
            for i in 1...10 {
                print("🔴 \(i)")
            }
        }
        
        queue2.async {
            for i in 1...10 {
                print("🟢 \(i)")
            }
        }
        
        for i in 1...10 {
            print("🟡 \(i)")
        }
    }
    
    
    func concurrentQueue() {
        let queue = DispatchQueue(label: "queue", qos: .utility, attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue = queue
        
        queue.async {
            for i in 1...10 {
                print("🟡 \(i)")
            }
        }
        
        queue.async {
            for i in 1...10 {
                print("🟢 \(i)")
            }
        }
        
        for i in 1...10 {
            print("🔴 \(i)")
        }
        
        
    }
    
    func fetchImage() {
        
        guard let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3a/Cat03.jpg")
        else { return }
        
        URLSession(configuration: .default).dataTask(with: imageUrl, completionHandler: {
            (imageData, response, error) in

            if let data = imageData {
                print("Bild nedladdad 💚")

                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }

        }).resume()

        
        print("Bildndeladdning startar 💙")
        
        
    }
    
    
    
    
    
}

