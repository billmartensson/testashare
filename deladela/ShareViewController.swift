//
//  ShareViewController.swift
//  deladela
//
//  Created by Bill Martensson on 2022-12-07.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    //class ShareViewController: UIViewController {
    
    var selectedRow : Int?
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        
        let contentTypeImage = kUTTypeImage as String
        
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentTypeImage) {
                attachment.loadItem(forTypeIdentifier: contentTypeImage, options: nil) { data, error in
                    
                    if error == nil {
                        let someUrl = data as? URL
                        let someData = data as? Data
                        
                        if(someUrl != nil)
                        {
                            
                            let sharedImage = UIImage(data: try! Data(contentsOf: someUrl!))
                            
                            
                        }
                        
                        if(someData != nil)
                        {
                            let sharedImage = UIImage(data: someData!)
                            
                            
                        }
                        
                    } else {
                        // ERROR
                    }
                }
            }
        }
        
        
        
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        
        let item = SLComposeSheetConfigurationItem()
        if(selectedRow == 0)
        {
            item?.title = "VALD Favoriter"
        } else {
            item?.title = "Favoriter"
        }
        item?.value = "Fav fav"
        item?.tapHandler = {
            print("AAAAA")
            self.selectedRow = 0
            self.reloadConfigurationItems()
        }
        
        let item2 = SLComposeSheetConfigurationItem()
        if(selectedRow == 1)
        {
            item2?.title = "VALD Best"
        } else {
            item2?.title = "Best"
        }
        item2?.value = "The best"
        item2?.tapHandler = {
            print("BBBBB")
            self.selectedRow = 1
            self.reloadConfigurationItems()
        }

        return [item, item2]
    }
    
}
