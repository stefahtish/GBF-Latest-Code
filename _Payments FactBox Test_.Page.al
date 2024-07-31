page 50376 "Payments FactBox Test"
{
    Caption = 'Drag and Drop';
    PageType = CardPart;
    SourceTable = Payments;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
            }
            // usercontrol(DragDrop; DragDropAddIn)
            // {
            //     ApplicationArea = All;
            //     trigger DataRead(data: Variant)
            //     var
            //         Text001: Label 'Document %1 has been successfully imported.';
            //     begin
            //         // SavePicture(data);
            //         if Counter = 0 then begin
            //             FileName := data;
            //             Counter := 1;
            //         end else begin
            //             Counter := 0;
            //             DocumentMgt.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId, data, FileName);
            //             Message(Text001, FileName);
            //         end;
            //     end;
            //     // trigger AddInReady()
            //     // begin
            //     //     ControlAddInReady := TRUE;
            //     //     UpdateClient;
            //     //     CurrPage.UPDATE(FALSE);
            //     // end;
            // }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        IF ControlAddInReady THEN BEGIN
            UpdateClient;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    var
        ControlAddInReady: Boolean;
        Path: text;
        DocumentMgt: Codeunit "Document Management";
        Counter: Integer;
    // procedure SavePicture(DataUrl: Text)
    // var
    //     MemStream: DotNet MemoryStream;
    //     RegEx: DotNet BCRegex;
    //     Match: DotNet BCMatch;
    //     Convert: DotNet BCConvert;
    //     OutStr: OutStream;
    //     CompInfo: Record "Company Information";
    // begin
    //     path := DataUrl;
    //     RegEx := RegEx.Regex('data\:image/(.*?);base64,(.*)');
    //     Match := RegEx.Match(DataUrl);
    //     IF Match.Success THEN BEGIN
    //         MemStream := MemStream.MemoryStream(Convert.FromBase64String(Match.Groups.Item(2).Value));
    //         CompInfo.Get();
    //         CompInfo.Picture.CREATEOUTSTREAM(OutStr);
    //         //   COPYSTREAM(OutStr, MemStream);
    //         CompInfo.MODIFY;
    //         CurrPage.UPDATE(FALSE);
    //     END /*ELSE
    //         ERROR('Invalid data type. Image expected.')*/;
    // end;
    procedure GetDataUriFromImage() DataUri: Text
    var
    /* Image: DotNet BCImage;
    ImageFormat: DotNet BCImageFormat;
    MemStream: DotNet BCMemoryStream;
    Instr: InStream;
    Convert: DotNet BCConvert; */
    begin
        /*  CALCFIELDS(Picture);
             IF Picture.HASVALUE THEN BEGIN
                 DataUri := 'data:image/';
                 Picture.CREATEINSTREAM(Instr);
                 MemStream := MemStream.MemoryStream;
                 COPYSTREAM(MemStream, Instr);
                 Image := Image.FromStream(MemStream);
                 ImageFormat := Image.RawFormat;
                 CASE TRUE OF
                     ImageFormat.Equals(ImageFormat.Gif):
                         DataUri += 'gif';
                     ImageFormat.Equals(ImageFormat.Jpeg):
                         DataUri += 'jpg';
                     ImageFormat.Equals(ImageFormat.Png):
                         DataUri += 'png';
                 END;

                 DataUri += ';base64,' + Convert.ToBase64String(MemStream.ToArray);
             END; */
    end;

    procedure UpdateClient()
    begin
        //edddie  CurrPage.DragDrop.SendData(GetDataUriFromImage);
    end;

    var
        FileName: Text;
}
