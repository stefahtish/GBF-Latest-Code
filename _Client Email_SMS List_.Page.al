page 50884 "Client Email/SMS List"
{
    Caption = 'Client Communication List';
    CardPageID = "Client Email/SMS Header Card";
    PageType = List;
    SourceTable = "Email/SMS Logging Header";
    SourceTableView = WHERE(Status = FILTER(Pending));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Document Email Type"; Rec."Document Email Type")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
    trigger OnOpenPage()
    begin
        // CALCFIELDS("E-Mail Body Text");
        // "E-Mail Body Text".CREATEINSTREAM(InStrm);
        // EmailBigTxt.READ(InStrm);
        // EmailTxt:=FORMAT(EmailBigTxt);
        //
        // CALCFIELDS("SMS Body Text");
        // "SMS Body Text".CREATEINSTREAM(InStrm);
        // SMSBigTxt.READ(InStrm);
        // SMSTxt:=FORMAT(SMSBigTxt);
    end;

    var
        NotificationType: array[2] of Boolean;
        Selection: Integer;
        Text000: Label 'You are about to generate client notifications for the selected period of the selected member(s) / Do you want to Proceed?';
        Text001: Label 'Email Client Notifications,&SMS Client Notifications';
}
