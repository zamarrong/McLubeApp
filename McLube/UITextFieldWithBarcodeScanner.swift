//
//  UITextFieldWithPickerView.swift
//  McLube
//
//  Created by Jorge Zamarrón on 08/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import AVFoundation
import UIKit
import RSBarcodes_Swift

class UITextFieldWithBarcodeScanner: UITextField, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var barcodesHandler: ((Array<AVMetadataMachineReadableCodeObject>) -> Void)?
    
    required init(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)!
        
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypePDF417Code]
        } else {
            failed()
            return
        }
        
       let scannerView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 100))

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = scannerView.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        captureSession.startRunning();
        
        let item : UITextInputAssistantItem = self.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []
        
        scannerView.layer.addSublayer(previewLayer)
        self.inputAccessoryView = scannerView
        
        self.barcodesHandler = { barcodes in
            for barcode in barcodes {
                self.text = barcode.stringValue
            }
        }
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        captureSession = nil
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        var barcodeObjects : Array<AVMetadataMachineReadableCodeObject> = []
        var cornersArray : Array<[AnyObject]> = []
        for metadataObject : AnyObject in metadataObjects {
            if let videoPreviewLayer =  previewLayer {
                let transformedMetadataObject = videoPreviewLayer.transformedMetadataObjectForMetadataObject(metadataObject as! AVMetadataObject)
                if transformedMetadataObject.isKindOfClass(AVMetadataMachineReadableCodeObject.self) {
                    let barcodeObject = transformedMetadataObject as! AVMetadataMachineReadableCodeObject
                    barcodeObjects.append(barcodeObject)
                    cornersArray.append(barcodeObject.corners)
                }
            }
        }
        
        if barcodeObjects.count > 0 {
            if let barcodesHandler = self.barcodesHandler {
                barcodesHandler(barcodeObjects)
            }
        }
    }
}