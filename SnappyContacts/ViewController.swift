//
//  ViewController.swift
//  SnappyContacts
//
//  Created by Michael G. Wallin on 12/11/17.
//  Copyright © 2017 Michael G. Wallin. All rights reserved.
//

import UIKit
import AddressBook;
import MobileCoreServices;

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openCamara(_ sender: Any) {
    }
    
    -(BOOL) launchCamaraControllerFromViewController: (UIViewController*) controller usingDelegate: (id <
    UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate {
    
    BOOL truefalse = [UIImagePickerController isSourceTypeAvailable:UIImagePickerCOntrollerSourceTypeCamara];
    
    if (!truefalse || (delegate == nill) || (controller == nill)) {
        NSLog(@"No camara exists on your device.");
        return NO;
    }
    
    UIImagePickerController *camaraController = [[UIImagePickerController alloc] init];
    
    camaraController.sourceType = UIImagePickerControllerSourceTypeCamara;
    camaraController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
        UIImagePickerControllerSourceTypeCamara];
    camaraController.allowEditing = NO;
    camaraController.delegate = delegate;
    
    [controller presentModalViewController:camaraController animated:YES];
    }
    
    -(void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
    {
        [picker dismissModalViewControllerAnimated:YES];
    }
    
    -(void) imagePickerController: (UIImagePickerController*) picker didFinishPickingMediaWithInfo:(NSDictionary *) info
    {
        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
        UIImage *originalImage, *editedImage, *imageaToSave;
    
        editedImage = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        if (editedImage)
            imageToSave = editedImage;
        else
            imageToSave = originalImage;
    
        [picker dismissModalViewControllerAnimated: YES];
        [self.imageView setImage:imageToSave];
    }
    
    @IBAction func sendToContacts(_ sender: Any) {
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
        ABRecord create = ABPersonCreate();
        
        ABRecordSetValue(create, kABPersonFirstNameProperty, (_bridge CFStringRef)nameText);
        ABMultiValueAddValueAndLabel(phoneNum, (_bridge CFStringRef) phoneNum, kABPersonPhoneMainLabel, NULL);
        ABPersonSetImageData(create, (-bridge CFDataRef)imageToSave, nil);
        
        ABAdressBookAddRecord(addressBookRef, create, nil);
        ABAddressBookSave(addressBookRef, nil);
    }
    
    @IBOutlet weak var nameText: UITextField!
    (IBAction)sendToCantacts:(UIButton *)sender {
        if (ABAdressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
            ABAdressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
            NSLog(@"Denied");
        else if (ABAdressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
            NSLog(@"Authorized");
        else
            NSLog(@"Not Determined");
    }
    @IBOutlet weak var phoneNum: UITextField!
    
    
    }
}

