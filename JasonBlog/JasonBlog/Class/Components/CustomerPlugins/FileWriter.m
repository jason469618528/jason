//
//  FileWriter.m
//  CustomPlugin
//
//  Created by Jesus Garcia on 8/12/13.
//
//

#import "FileWriter.h"

@implementation FileWriter

- (void) cordovaGetFileContents:(CDVInvokedUrlCommand *)command {
    
    // Retrieve the date String from the file via a utility method
    NSString *dateStr = [self getFileContents];
    
    // Create an object that will be serialized into a JSON object.
    // This object contains the date String contents and a success property.
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             dateStr, @"dateStr",
                             @"true", @"success",
                             nil
                             ];
    
    // Create an instance of CDVPluginResult, with an OK status code.
    // Set the return message as the Dictionary object (jsonObj)...
    // ... to be serialized as JSON in the browser
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    // Execute sendPluginResult on this plugin's commandDelegate, passing in the ...
    // ... instance of CDVPluginResult
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) cordovaSetFileContents:(CDVInvokedUrlCommand *)command
{
    NSLog(@"TEST");
    self.viewController.tabBarController.selectedIndex = 0;
}

#pragma mark - Util_Methods
// Dives into the file system and writes the file contents.
// Notice fileContents as the first argument, which is of type NSString
- (void) setFileContents:(NSString *)fileContents {
    
    // Create an array of directory Paths, to allow us to get the documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // The documents directory is the first item
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Create a string that prepends the documents directory path to a text file name
    // using NSString's stringWithFormat method.
    NSString *fileName = [NSString stringWithFormat:@"%@/myTextFile.txt", documentsDirectory];
    
    // Here we save contents to disk by executing the writeToFile method of
    // the fileContents String, which is the first argument to this function.
    [fileContents writeToFile : fileName
                  atomically  : NO
                  encoding    : NSStringEncodingConversionAllowLossy
                  error       : nil];
}

//Dives into the file system and returns contents of the file
- (NSString *) getFileContents{
    
    // These next three lines should be familiar to you.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"%@/myTextFile.txt", documentsDirectory];
    
    // Allocate a string and initialize it with the contents of the file via
    // the initWithContentsOfFile instance method.
    NSString *fileContents = [[NSString alloc]
                              initWithContentsOfFile : fileName
                              usedEncoding           : nil
                              error                  : nil
                              ];
    
    // Return the file contents String to the caller (cordovaGetFileContents)
    return fileContents;
}

@end
