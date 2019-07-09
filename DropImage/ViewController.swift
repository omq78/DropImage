//
//  ViewController.swift
//  DropImage
//
//  Created by Omar Alqabbani on 7/6/19.
//  Copyright © 2019 OmarALqabbani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDropInteractionDelegate, UIDragInteractionDelegate  {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        
        let location = session.location(in: self.view)
        let selectedView = view.hitTest(location, with: nil) as? UIImageView
        
        if let iamgeView = selectedView?.image {
            let itemProvider = NSItemProvider(object: iamgeView)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.localObject = selectedView
            return [dragItem]
        }
        return []
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        return UITargetedDragPreview(view: item.localObject as! UIImageView)
    }
    
    
    func dragInteraction(_ interaction: UIDragInteraction, willAnimateLiftWith animator: UIDragAnimating, session: UIDragSession) {
        
        session.items.forEach { (draggedItem) in
            let image = draggedItem.localObject as! UIImageView
            image.removeFromSuperview()
        }
        
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, item: UIDragItem, willAnimateCancelWith animator: UIDragAnimating) {
        self.view.addSubview(item.localObject as! UIView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addInteraction(UIDropInteraction(delegate: self))
        view.addInteraction(UIDragInteraction(delegate: self))
    }
    
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for item in session.items {
            item.itemProvider.loadObject(ofClass: UIImage.self) { (obj, err) in
                if let error = err {
                    print("error loading image")
                    print(error.localizedDescription)
                    return
                }
                
                guard let draggedImage = obj as? UIImage else {return}
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: draggedImage)
                    imageView.isUserInteractionEnabled = true
                    imageView.frame = CGRect(x: 0, y: 0, width: draggedImage.size.width, height: draggedImage.size.height)
                    let imageCenter = session.location(in: self.view)
                    imageView.center = imageCenter
                    self.view.addSubview(imageView)
                }
            }
        }
    }
    
}


