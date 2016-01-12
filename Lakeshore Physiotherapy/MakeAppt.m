//
//  MakeAppt.m
//  Lakeshore Physiotherapy
//
//  Created by Tristan Secord on 2014-09-01.
//  Copyright (c) 2014 Tristan Secord. All rights reserved.
//

#import "MakeAppt.h"

@interface MakeAppt ()

@property (nonatomic) IBOutlet UITextField *Name;
@property (nonatomic) IBOutlet UITextField *phoneNumber;
@property (nonatomic) IBOutlet UITextView *Description;
@property (nonatomic) IBOutlet UIDatePicker *dateAndTime;
@property (nonatomic) IBOutlet UITextField *Email;
- (IBAction)submit:(id)sender;

@end

@implementation MakeAppt

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 900)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.Name resignFirstResponder];
    [self.phoneNumber resignFirstResponder];
    [self.Description resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.placeholder = @"Enter your conditions";
}

#pragma mark - IBAction methods
- (IBAction)submit:(id)sender {
    
    if ([MFMailComposeViewController canSendMail])
    {
        //email subject
        NSString * subject = @"Make Appointment";
        //email body
        NSString *name = self.Name.text;
        NSString *phoneNumber = self.phoneNumber.text;
        NSString *description = self.Description.text;
        NSString *email = self.Email.text;
        NSDate *date = self.dateAndTime.date;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        NSString *body1= @"Name: ";
        NSString *bodyWithName = [body1 stringByAppendingString:name];
        NSString *body2 = [bodyWithName stringByAppendingString:@"\n\nPhone Number: "];
        NSString *bodyWithPN = [body2 stringByAppendingString:phoneNumber];
        NSString *body3 = [bodyWithPN stringByAppendingString:@"\n\nEmail: "];
        NSString *bodyWithEmail = [body3 stringByAppendingString:email];
        NSString *body4 = [bodyWithEmail stringByAppendingString:@"\n\nPreferred Date: "];
        NSString *bodyWithDescription =[body4 stringByAppendingString: dateString];
        NSString *body5 = [bodyWithDescription stringByAppendingString:@"\n\nDescription:\n"];
        NSString *body = [body5 stringByAppendingString:description];
        
        //recipient(s)
        NSArray * recipients = [NSArray arrayWithObjects:@"physiotherapyonlakeshore@gmail.com", nil];
        
        //create the MFMailComposeViewController
        MFMailComposeViewController * composer = [[MFMailComposeViewController alloc] init];
        composer.mailComposeDelegate = self;
        [composer setSubject:subject];
        [composer setMessageBody:body isHTML:NO];
        [composer setToRecipients:recipients];
        
        //get the filepath from resources
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PoL" ofType:@"png"];
        
        //read the file using NSData
        NSData * fileData = [NSData dataWithContentsOfFile:filePath];
        // Set the MIME type
        /*you can use :
         - @"application/msword" for MS Word
         - @"application/vnd.ms-powerpoint" for PowerPoint
         - @"text/html" for HTML file
         - @"application/pdf" for PDF document
         - @"image/jpeg" for JPEG/JPG images
         */
        NSString *mimeType = @"image/png";
        
        //add attachement
        [composer addAttachmentData:fileData mimeType:mimeType fileName:filePath];
        
        //present it on the screen
        [self presentViewController:composer animated:YES completion:NULL];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate methods
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
