table 50477 "Dispatched Letter Register"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = true;
        }
        field(2; Date; Date)
        {
        }
        field(3; REF; Code[10])
        {
        }
        field(4; Address; Text[30])
        {
        }
        field(5; Subject; Text[200])
        {
        }
        field(6; Department; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(7; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(8; Type; Option)
        {
            OptionCaption = 'Incoming,Outgoing';
            OptionMembers = Incoming, Outgoing;
        }
        field(9; Send; Boolean)
        {
        }
        field(10; Received; Boolean)
        {
        }
        field(11; "Date Send"; Date)
        {
        }
        field(12; "Received Date"; Date)
        {
        }
        field(13; "Filed at Registry"; Boolean)
        {
        }
        field(14; Receiver; Code[20])
        {
        }
        field(15; Sender; Code[20])
        {
        }
        field(16; "Action Officer 1 No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Action Officer 1 No.")then begin
                    "Action Officer1 Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Action Officer 1 Email":=Emp."E-Mail";
                end;
            end;
        }
        field(17; From; Text[120])
        {
        }
        field(18; "To/Action"; Text[120])
        {
        }
        field(20; "Dispatch Date"; Date)
        {
        }
        field(21; "Remarks/ FILE No."; Text[250])
        {
        }
        field(22; "Action Officer1 Name"; Text[50])
        {
        }
        field(23; "External Dispatch type"; Option)
        {
            OptionCaption = 'Postage, Hand delivery';
            OptionMembers = Postage, " Hand delivery";
        }
        field(24; "Action Officer 2 No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Action Officer 2 No.")then begin
                    "Action Officer2 Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Action Officer 2 Email":=Emp."E-Mail";
                end;
            end;
        }
        field(25; "Action Officer2 Name"; Text[50])
        {
        }
        field(26; "Action Officer 3 No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Action Officer 3 No.")then begin
                    "Action Officer3 Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Action Officer 3 Email":=Emp."E-Mail";
                end;
            end;
        }
        field(27; "Action Officer3 Name"; Text[50])
        {
        }
        field(28; "Action Officer 4 No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Action Officer 4 No")then begin
                    "Action Officer 4 Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Action officer 4 Email":=Emp."E-Mail";
                end;
            end;
        }
        field(29; "Action Officer 4 Name"; Text[50])
        {
        }
        field(30; Dispartched; Boolean)
        {
        }
        field(31; "Action Officer 1 Email"; Text[60])
        {
        }
        field(32; "Action Officer 2 Email"; Text[60])
        {
        }
        field(33; "Action Officer 3 Email"; Text[60])
        {
        }
        field(34; "Action officer 4 Email"; Text[60])
        {
        }
        field(35; "Internal Dispatch type"; Option)
        {
            OptionCaption = 'Scanned copy in ADA,Hard copy';
            OptionMembers = "Scanned copy in ADA", "Hard copy";
        }
        field(36; "Received by Action Officer"; Boolean)
        {
        }
        field(37; "Action Officer Remarks"; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            RMSetup.Get;
            RMSetup.TestField(RMSetup.Mails);
            NoSeriesMgt.InitSeries(RMSetup.Mails, xRec."No. Series", 0D, "No.", "No. Series");
        end;
    /*
        IF "Invoice Disc. Code" = '' THEN
          "Invoice Disc. Code" := "No.";
        
        IF NOT InsertFromContact THEN
          UpdateContFromCust.OnInsert(Rec);
         */
    /*
        MonthText:=FORMAT(DATE2DMY(TODAY, 2));
        MESSAGE(MonthText);
        YearText:=FORMAT(DATE2DMY(TODAY, 3));
        DateText:=MonthText+'/'+YearText;
        MESSAGE(Rec."No.");
        DispatchRec.RESET;
        DispatchRec.SETFILTER("No.",'=%1*',MonthText);
        IF DispatchRec.FIND('+') THEN
        "No.":=INCSTR(xRec."No.")
        ELSE
        "No.":=DateText+'/01';
        
        Sender:=USERID;
        "Action Officer1 Name":=USERID;
        */
    end;
    var ResourceSetup: Record "Resource Centre Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Emp: Record Employee;
    UserSetup: Record "User Setup";
    DateText: Text[30];
    NewCode: Code[10];
    MonthText: Text[30];
    YearText: Text[30];
    DispatchRec: Record "Dispatched Letter Register";
    SMTP: Codeunit "Email Message";
    RMSetup: Record "Resource Centre Setup";
    procedure Notifications()
    var
        SenderName: Text[100];
        SenderAddress: Text[60];
        Body: Text[250];
        Recipients: Text[250];
        Subject: Text[30];
    begin
        TestField("Action Officer 1 Email");
        TestField("Action Officer 2 Email");
        TestField("Action Officer 3 Email");
        TestField("Action officer 4 Email");
        SenderName:=UserId;
        if UserSetup.Get(UserId)then SenderAddress:=UserSetup."E-Mail";
        Recipients:="Action Officer 1 Email" //Body:='Please action of the Email Register No: '+"No.";
    //SMTP.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
    //SMTP.Send();
    end;
}
