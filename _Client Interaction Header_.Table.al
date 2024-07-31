table 50462 "Client Interaction Header"
{
    DrillDownPageID = "Interaction List";
    LookupPageID = "Interaction List";

    fields
    {
        field(1; "Interact Code"; Code[20])
        {
        }
        field(2; "Date and Time"; DateTime)
        {
            trigger OnValidate()
            begin
                "Last Updated Date and Time":="Date and Time";
                Modify;
            end;
        }
        field(3; "Client No."; Code[20])
        {
            TableRelation = IF("Client Type"=FILTER("External Contact"))Contact
            ELSE IF("Client Type"=CONST(Employee))Employee
            ELSE IF("Client Type"=CONST(Supplier))Vendor
            else IF("Client Type"=CONST(Customer))Customer;

            trigger OnValidate()
            begin
                case "Client Type" of "Client Type"::"External Contact": begin
                    recExternalClient.Get("Client No.");
                    "Client Name":=recExternalClient.Name;
                    "Client Email":=recExternalClient."E-Mail";
                    "Client Phone No.":=recExternalClient."Phone No.";
                end;
                "Client Type"::Customer: begin
                    recCust.Get("Client No.");
                    "Client Name":=recCust.Name;
                    "Client Email":=recCust."E-Mail";
                    "Client Phone No.":=recCust."Phone No.";
                end;
                "Client Type"::Employee: begin
                    EmpRec.Get("Client No.");
                    "Client Name":=EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    "Client Email":=EmpRec."Company E-Mail";
                    "Client Phone No.":=EmpRec."Phone No.";
                end;
                "Client Type"::Supplier: begin
                    Supplier.get("Client No.");
                    "Client Name":=Supplier.Name;
                    "Client Email":=Supplier."E-Mail";
                    "Client Phone No.":=Supplier."Phone No.";
                end;
                end;
            end;
        }
        field(4; "Interaction Type No."; Code[20])
        {
            TableRelation = "Interaction Type"."No." WHERE("Interaction Type"=FIELD("Interaction Type"));

            trigger OnValidate()
            begin
                //recInteractType.GET("Interaction Type No.");
                //"Interaction Type Desc." := recInteractType.Description;
                if "Interaction Type No." <> '' then //  recInteractType.SETRANGE(recInteractType."No.","Interaction Type No.");
                    recInteractType.SetRange(recInteractType."No.", "Interaction Type No.");
                //  message('%1 <---<< ',"Interaction Type No.");
                if recInteractType.FindFirst then "Interaction Type Desc.":=recInteractType.Description;
            // MESSAGE('%1 is ',"Interaction Type No.");
            end;
        }
        field(5; "Interaction Resolution No."; Code[20])
        {
            TableRelation = "Interaction Resolution"."No." WHERE("Interaction No."=FIELD("Interaction Type No."), "Cause No."=FIELD("Interaction Cause No."));

            trigger OnValidate()
            begin
                //"Interaction Resolution No."
                //recInteractResolution.GET("Interaction Resolution No.");
                //MESSAGE('%1 IS ',recInteractResolution);
                //"Interaction Resolution Desc." := recInteractResolution.Description;
                //Code for filling in the resolution steps for reference
                if "Interaction Resolution No." <> '' then begin
                    //  CRMRTS stands for CRMResolutionTaskStatus
                    //   CRMRTS.SETCURRENTKEY(IRCode);
                    //    CRMRTS.SETRANGE(CRMRTS.IRCode,"Interaction Resolution No.");
                    CRMRTS.SetRange(CRMRTS."Interaction Header No.", "Interact Code");
                    CRMRTS.DeleteAll;
                end;
                //Add the steps for resolution.
                begin
                    CRMResolutionSteps.SetCurrentKey("Interaction Resol. Code");
                    CRMResolutionSteps.SetRange(CRMResolutionSteps."Interaction Resol. Code", "Interaction Resolution No.");
                    if CRMResolutionSteps.FindFirst then repeat // process record
                            //MESSAGE('Goes through these steps');
                            CRMRTS.Init;
                            CRMRTS."Interaction Header No.":="Interact Code";
                            CRMRTS."Interation Reso. Code":=CRMResolutionSteps."Interaction Resol. Code";
                            CRMRTS."Step No.":=CRMResolutionSteps."Step Number";
                            CRMRTS."Resolution Description":=CRMResolutionSteps."Resolution Description";
                            if not CRMRTS.Get(CRMRTS."Interaction Header No.", CRMRTS."Interation Reso. Code", CRMRTS."Step No.")then CRMRTS.Insert;
                        until CRMResolutionSteps.Next = 0;
                end;
            end;
        }
        field(6; Notes; Text[2000])
        {
        }
        field(7; "User ID"; Code[50])
        {
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Pending for Action,Complete';
            OptionMembers = "Pending for Action", Complete;
        }
        field(9; "Assigned to User"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(10; "Last Updated Date and Time"; DateTime)
        {
        }
        field(11; "Interaction Channel"; Code[20])
        {
            TableRelation = "Interaction Channel";
        }
        field(12; "Is Escalated"; Boolean)
        {
        }
        field(13; "Interaction Type Desc."; Text[100])
        {
        }
        field(14; "Interaction Type";enum "CRM Interaction Types")
        {
            trigger OnValidate()
            begin
                if "Interaction Type" <> xRec."Interaction Type" then begin
                    "Interaction Type No.":='';
                    "Interaction Type Desc.":='';
                end;
            end;
        }
        field(15; "Assigned Flag"; Boolean)
        {
        }
        field(16; "Escalation Level No."; Integer)
        {
        }
        field(17; "Escalation Level Name"; Text[200])
        {
        }
        field(18; "Escalation Clock"; DateTime)
        {
            trigger OnValidate()
            begin
                "Escalation Clock":=CreateDateTime(WorkDate, Time);
            end;
        }
        field(19; "Interaction Resolution Desc."; Text[250])
        {
        }
        field(20; "Assign Remarks"; Text[2000])
        {
            trigger OnValidate()
            var
                SenderName: Text[30];
                SenderAddress: Text[100];
            begin
            /*
                IF CONFIRM(STRSUBSTNO('Do you want to assign this interaction to %1?',"Assigned to User"), TRUE) THEN
                     BEGIN
                        //BEGIN
                        //IF "Assigned Flag" THEN
                        //  ERROR(Text002);
                        IF recUserSetup.GET(USERID) THEN
                           SenderAddress:=recUserSetup."E-Mail";
                        IF recUserSetup.GET("Assigned to User") THEN
                          BEGIN
                          txtLineDescription := 'Assigned to User ' + "Assigned to User";
                          InsertDetailLine('System','Assigned',txtLineDescription);
                          "Assigned Flag" := TRUE;
                          Status := Status::Assigned;
                          "Escalation Clock" := CREATEDATETIME(WORKDATE,TIME);;
                          ToName:=recUserSetup."E-Mail";
                          CompanyInformation.GET('');
                          CCName:=CompanyInformation."E-Mail";
                          Subject:=STRSUBSTNO('Escalation of Incident %1 for Client %2',"Interact Code","Client Name");
                          Body:="Assign Remarks"+' For ' +FORMAT("Client Type") +'Client: ' +"Client Name";
                
                          IF "Assign Remarks"<>'' THEN
                            Body:="Assign Remarks"
                          ELSE
                            Body:='Please act on this interaction.!!!!!!!!!!!';
                          END;
                          AttachFileName:='';
                          OpenDialog:=TRUE;
                          // Body:="Assign Remarks";
                          SMPTPMail.CreateMessage(USERID,SenderAddress,ToName,Subject,Body,TRUE);
                          SMPTPMail.Send();
                          MESSAGE('Assigned to %1 successfully',"Assigned to User");
                  END;
                */
            end;
        }
        field(21; "Unit Assigned"; Code[20])
        {
        }
        field(22; "Date of Interaction"; Date)
        {
            Caption = 'Date Received';
        }
        field(23; "Channel Sub Type"; Code[20])
        {
        }
        field(24; "Client Name"; Text[100])
        {
        }
        field(25; "Client Feedback"; Text[250])
        {
        }
        field(26; "Reviewing Officer Remarks"; Text[250])
        {
        }
        field(27; "Interaction Cause No."; Code[20])
        {
            TableRelation = "Interaction Cause"."No." WHERE("Interaction No."=FIELD("Interaction Type No."));

            trigger OnValidate()
            begin
                //recInteractCause.GET("Interaction Cause No.");
                //"Interaction Cause Desc." := recInteractCause.Description;
                if "Interaction Cause No." <> '' then recInteractionCause.SetRange(recInteractionCause."No.", "Interaction Cause No.");
                if recInteractionCause.FindFirst then "Interaction Cause Desc.":=recInteractionCause.Description;
                recResolution.SetRange(recResolution."Interaction No.", "Interaction Type No.");
                recResolution.SetRange(recResolution."Cause No.", "Interaction Cause No.");
                if recResolution.FindFirst then begin
                    "Interaction Resolution No.":=recResolution."No.";
                    Validate("Interaction Resolution No.");
                    recResolution.CalcFields(recResolution.Description);
                    "Interaction Resolution Desc.":=recResolution.Description;
                //MESSAGE('%1',recResolution.Description);
                end;
            end;
        }
        field(28; "Interaction Cause Desc."; Text[250])
        {
        }
        field(29; "Major Category"; Option)
        {
            OptionCaption = 'Client Services,Contact Centre,Complaints Bureau';
            OptionMembers = "Client Services", "Contact Centre", "Complaints Bureau";
        }
        field(30; "No. Series"; Code[20])
        {
        }
        field(31; "Client Type";Enum "CRM Client Types")
        {
        }
        field(32; Archived; Boolean)
        {
        }
        field(33; Agent; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                if AgentRec.Get(Agent)then;
                "Agent Name":=AgentRec.Name;
            end;
        }
        field(34; "Agent Name"; Text[150])
        {
            Editable = false;
        }
        field(35; ClientTypeID; Code[30])
        {
            TableRelation = "Client Types";
        }
        field(36; Company; Text[50])
        {
        }
        field(37; "Client Phone No."; Code[30])
        {
        }
        field(38; "Client Email"; Text[100])
        {
        }
        field(39; "Branch Code"; Code[30])
        {
            TableRelation = "Dimension Value";
        }
        field(40; "Datetime Claim Received"; DateTime)
        {
            Caption = 'Date Received';
            DataClassification = ToBeClassified;
        }
        field(41; "Datetime Claim Updated"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Datetime Claim Assigned"; DateTime)
        {
            Caption = 'Date Acknowledged';
            DataClassification = ToBeClassified;
        }
        field(43; "Datetime Claim Closed"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(46; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            var
                DimValues: Record "Dimension Value";
                UserSetup: Record "User Setup";
            begin
                DimValues.Reset();
                DimValues.SetRange("Global Dimension No.", 2);
                DimValues.SetRange(Code, "Global Dimension 2 Code");
                if DimValues.FindFirst()then "Departmental Email":=DimValues.Email;
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                UserSetup.Reset();
                UserSetup.SetRange("HOD User", true);
                UserSetup.SetRange(Department, "Global Dimension 2 Code");
                if UserSetup.FindFirst()then "HR user ID":=UserSetup."User ID";
            end;
        }
        field(47; "Registry Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Registry User"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";
        }
        field(51; "Registry User DateTime Receive"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Registry User DateTime Closed"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(57; "User DateTime Received"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "User DateTime Closed"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Closed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Closed DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Client Log Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Client Communication Phone No."; Code[30])
        {
            CharAllowed = ' 1,2,3,4,5,6,7,8,9,0';
            DataClassification = ToBeClassified;
        }
        field(67; "Client Comminication E-Mail"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                MailManagement.ValidateEmailAddressField("Client Comminication E-Mail");
            end;
        }
        field(80; "Escalation To User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(81; "Escalation Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Escalation Employee No."; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Escalation Employee Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Escalation Employee Email"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "New Escalator No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(86; Issue; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Hr Comment"; Blob)
        {
            Caption = 'Resolution remarks';
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(88; "Problem Reported"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(89; Resolve; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "HR user ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(91; Stage; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Initial, Department, Escalated, HOD, MD, Corporate, Closed, Archived;
        }
        field(92; "MD user ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(93; Approve; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(94; "Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Remarks/ Observation"; Text[2040])
        {
            DataClassification = ToBeClassified;
        }
        field(96; "Archived By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(97; "Archived DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(98; "Departmental Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Interact Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        CompInceLine.Reset;
        CompInceLine.SetRange(CompInceLine."Client Interaction No.", "Interact Code");
        CompInceLine.DeleteAll;
    end;
    trigger OnInsert()
    begin
        if "Interact Code" = '' then begin
            InteractSetup.Get;
            InteractSetup.TestField(Interact);
            NoSeriesMgt.InitSeries(InteractSetup.Interact, xRec."No. Series", 0D, "Interact Code", "No. Series");
            if recUserSetup.Get(UserId)then //recUserSetup.TESTFIELD("Global Dimension 1 Code");
                "User ID":=UserId;
            "User DateTime Received":=CreateDateTime(Today, Time);
            "Global Dimension 1 Code":=recUserSetup."Global Dimension 1 Code";
        // "Global Dimension 2 Code" := recUserSetup."Global Dimension 2 Code";
        end;
        if GetFilter("Client No.") <> '' then if GetRangeMin("Client No.") = GetRangeMax("Client No.")then Validate("Client No.", GetRangeMin("Client No."));
        Company:=CompanyName;
        //"Date and Time" := CURRENTDATETIME;
        "Date and Time":=CreateDateTime(WorkDate, Time);
        "Last Updated Date and Time":=CreateDateTime(WorkDate, Time);
        InsertInitialLog(Rec);
    end;
    trigger OnModify()
    begin
        "Last Updated Date and Time":=CreateDateTime(WorkDate, Time);
    end;
    var recUserSetup: Record "User Setup";
    recClient: Record Customer;
    CompanyInformation: Record "Company Information";
    InteractSetup: Record "Marketing Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    recInteractType: Record "Interaction Type";
    recInteractCause: Record "Interaction Cause";
    recInteractResolution: Record "Interaction Resolution";
    recResolution: Record "Interaction Resolution";
    CRMResolutionTaskStatus: Record "Resolution of Tasks Status";
    CRMResolutionSteps: Record "Resolution Steps";
    CRMRTS: Record "Resolution of Tasks Status";
    recInteractionsSetup: Record "Interaction Setup";
    recClientInteractLine: Record "Client Interaction Line";
    recInteractionType: Record "Interaction Type";
    recInteractionCause: Record "Interaction Cause";
    ComplaintLine: Record "Client Interaction Line";
    CompChannel: Record "Interaction Channel";
    CompInceLine: Record "Client Interaction Line";
    txtLineDescription: Text[250];
    NavMail: Codeunit Mail;
    SMPTPMail: Codeunit "Email Message";
    ToName: Text[60];
    CCName: Text[60];
    Subject: Text[250];
    Body: Text[250];
    AttachFileName: Text[250];
    OpenDialog: Boolean;
    recDimension: Record "Dimension Value";
    Smtp: Codeunit "Email message";
    Text001: Label 'Status cannot be manually changed to Escalated!';
    Text002: Label 'Assigned Interactions cannot be deleted';
    Text003: Label 'There is no Step %1 to be %2';
    recCust: Record Customer;
    Period: Duration;
    recExternalClient: Record Contact;
    EmpRec: Record Employee;
    AgentRec: Record "Salesperson/Purchaser";
    Text004: Label 'Please insert the Agent as it''s not updated in the member card';
    Text005: Label 'Dear %1 your claim has been received on %2. Your reference no. is %3. We confirm that your benefits shall be processed within 21 working days.';
    Text006: Label 'The Claim received action shall move the claim to registry and notify the client of receipt of claim \ Are you sure you want to proceed?';
    Text007: Label 'Are you sure you want to notify operations that member record has been updated?';
    SMTPMail: Codeunit "Email Message";
    Email: Codeunit Email;
    UserDetails: Record User;
    SenderName: Text;
    Text008: Label 'SF NO: %1 %2  records have been updated accordingly';
    Text009: Label '<p style="font-family:Verdana,Arial;font-size:10pt">To Operations,</p><p style="font-family:Verdana,Arial;font-size:9pt"> The above member record has been updated accordingly. Dear <b>%2</b>, please proceed to process the Claim No. <b>%3</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Regards, <br/> %1</p>';
    Text010: Label 'SF NO: %1 %2  records need to be updated accordingly';
    Text011: Label 'Dear Sir/Madam <p> The above member record needs to be updated accordingly </p>  <br/>Regards, <br/> %1';
    Text012: Label 'Are you sure you want to assign this to %1?';
    recUserSetup1: Record "User Setup";
    Text013: Label 'SF NO: %1 %2 Claim Assignment';
    Text014: Label 'Dear %1 <p> The above claim has been assigned to you, kindly process it accordingly. </p> <p>%2 </p> <p> Regards, <br/> %3';
    Text015: Label 'Are you sure you want to create a member clearance for %1 %2?';
    DimMgt: Codeunit DimensionManagement;
    InteractionSetup: Record "Interaction Setup";
    MailManagement: Codeunit "Mail Management";
    NewPhoneNo: Code[30];
    CharStriPos: Integer;
    Text016: Label 'Are you sure you want to Escalate this to %1?';
    Text017: Label 'Escalation Assignment for Interaction: %1';
    Text018: Label 'Dear %1 <p> The above Interaction has been escalated to you, kindly process it accordingly. </p> <p>Here are my reamarks: %2 </p> <p> Regards, <br/> %3';
    Recipient: list of[Text];
    Supplier: Record Vendor;
    procedure AssistEdit(OldInce: Record "Client Interaction Header"): Boolean var
        Ince: Record "Client Interaction Header";
    begin
        //C002
        Ince:=Rec;
        if recInteractionsSetup.FindFirst then begin
            recInteractionsSetup.TestField(recInteractionsSetup."Client Interaction Header Nos.");
            if NoSeriesMgt.SelectSeries(recInteractionsSetup."Client Interaction Header Nos.", OldInce."No. Series", Ince."No. Series")then begin
                recInteractionsSetup.TestField(recInteractionsSetup."Client Interaction Header Nos.");
                NoSeriesMgt.SetSeries(Ince."Interact Code");
                Rec:=Ince;
                exit(true);
            end;
        end;
    //C002
    end;
    procedure InsertDetailLine(ptxtLineType: Text[30]; ptxtActionType: Text[30]; ptxtDescription: Text[250])
    var
        lintLineNo: Integer;
        lClIntHdr: Record "Client Interaction Header";
    begin
        //C004
        recClientInteractLine.Reset;
        recClientInteractLine.SetRange("Client Interaction No.", "Interact Code");
        if recClientInteractLine.FindLast then lintLineNo:=recClientInteractLine."Line No." + 10000
        else
            lintLineNo:=10000;
        recClientInteractLine.Init;
        recClientInteractLine."Client Interaction No.":="Interact Code";
        recClientInteractLine."Line No.":=lintLineNo;
        Evaluate(recClientInteractLine."Line Type", ptxtLineType);
        Evaluate(recClientInteractLine."Action Type", ptxtActionType);
        recClientInteractLine."User ID":=UserId;
        recClientInteractLine."Date and Time":=CreateDateTime(WorkDate, Time);
        ;
        recClientInteractLine.Description:=ptxtDescription;
        recClientInteractLine.Insert;
        if(ptxtActionType = 'Assigned') or (ptxtActionType = 'Escalated') or (ptxtActionType = 'Response Out') or (ptxtActionType = 'Reply In')then "Escalation Clock":=CreateDateTime(WorkDate, Time);
        ;
        // if ptxtActionType = 'Response Out' then
        //     Status := Status::"Awaiting 3rd Party";
        // if ptxtActionType = 'Reply In' then
        //     if "Escalation Level No." > 0 then
        //         Status := Status::Escalated
        //     else
        //         Status := Status::Assigned;
        // if ptxtActionType = 'Closed' then
        //     Status := Status::Closed;
        "Last Updated Date and Time":=CreateDateTime(WorkDate, Time);
        ;
        Modify;
    /*
        ComplaintLine.RESET;
        ComplaintLine.INIT;
        ComplaintLine."Line No." := GetNextLineNo(ComplaintLine,FALSE);
        ComplaintLine."Client Interaction No." := "Client No.";
        //ComplaintLine."Client Code" := "Client No.";
        ComplaintLine."User Id (Reg. By)" := "User ID";
        ComplaintLine."Assigned to User" := "Assigned to User";
        ComplaintLine.Status := Status;
        ComplaintLine."Escalation Level No." := "Escalation Level No.";
        ComplaintLine.Notes := Notes;
        ComplaintLine.INSERT;
        */
    //C004
    end;
    procedure GetNextLineNo(CompLine: Record "Client Interaction Line"; BelowxRec: Boolean): Integer var
        CompLine2: Record "Client Interaction Line";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        NextLineNo:=0;
        LineStep:=10000;
        CompLine2.Reset;
        CompLine2.SetRange("Client Interaction No.", "Interact Code");
        if CompLine2.FindLast then NextLineNo:=CompLine2."Line No." + LineStep
        else
            NextLineNo:=LineStep;
        exit(NextLineNo);
    end;
    procedure OpenCard()
    begin
        case "Client Type" of "Client Type"::Customer: begin
            if recCust.Get("Client No.")then PAGE.Run(Page::"Customer Card", recClient);
        end;
        "Client Type"::"External Contact": begin
            if recExternalClient.Get("Client No.")then PAGE.Run(page::"Contact Card", recExternalClient);
        end;
        "Client Type"::Supplier: begin
            if Supplier.get("Client No.")then page.run(page::"Vendor Card", Supplier);
        end;
        "Client Type"::Employee: begin
            if EmpRec.get("Client No.")then page.run(page::"Employee Card", EmpRec);
        end;
        else
            exit;
        end;
    end;
    procedure InteractionStatus()RGBCode: Integer begin
    // case Status of
    //     Status::Logged:
    //         exit(65280);
    //     Status::Assigned:
    //         exit(128);
    //     Status::Escalated:
    //         exit(16711680);
    //     Status::"Awaiting 3rd Party":
    //         exit(8421504);
    //     Status::Closed:
    //         exit(255);
    //     else
    //         exit(0);
    // end;
    end;
    procedure Archive()
    var
        Date: Date;
    begin
    /* IF recInteractionsSetup.GET THEN
            Period:=(CREATEDATETIME(TODAY,TIME)-"Date and Time");
             IF Period>recInteractionsSetup."Archive Period" THEN
                  Archived := TRUE;
                  MODIFY;
        */
    end;
    procedure ClaimRcvd(var ClientRec: Record "Client Interaction Header")
    var
        Result: Text;
        Resolution: Record "Resolution of Tasks Status";
        StepNo: Integer;
    begin
        if not Confirm(Text006, false)then exit;
        //ClientRec.TESTFIELD("Client Phone No.");
        ClientRec.TestField("Client Communication Phone No.");
        //Notify Registry
        UserDetails.Reset;
        UserDetails.SetRange("User Name", UserId);
        if UserDetails.FindFirst then if UserDetails."Full Name" <> '' then SenderName:=UserDetails."Full Name"
            else
                SenderName:=UserId;
        if recUserSetup.Get(UserId)then;
        recUserSetup.TestField("E-Mail");
        recInteractionsSetup.Get();
        recInteractionsSetup.TestField("Registry Email");
        Clear(SMTPMail);
        Recipient.Add(recInteractionsSetup."Registry Email");
        SMTPMail.Create(Recipient, StrSubstNo(Text010, ClientRec."Client No.", ClientRec."Client Name"), StrSubstNo(Text011, SenderName), true);
        Email.Send(SMTPMail);
        //Assign Claim to Registry
        // ClientRec.Status := ClientRec.Status::Registry;
        //updates time sending claim going to registry
        ClientRec."Datetime Claim Received":=CreateDateTime(Today, Time);
        //updates time sending to Registry
        ClientRec."User DateTime Closed":=CreateDateTime(Today, Time);
        ClientRec.Modify;
        //MESSAGE(Result);
        //Log
        Resolution.Reset;
        Resolution.SetCurrentKey("Step No.");
        Resolution.SetRange("Interaction Header No.", ClientRec."Interact Code");
        if Resolution.FindLast then StepNo:=Resolution."Step No."
        else
            StepNo:=0;
        Resolution.Init;
        Resolution."Interaction Header No.":=ClientRec."Interact Code";
        Resolution."Interation Reso. Code":=ClientRec."Interact Code";
        Resolution."Resolution Description":='Sent To Registry';
        Resolution."Resolution Status":=Resolution."Resolution Status"::Completed;
        Resolution."Step No.":=StepNo + 1;
        Resolution."Document No":=ClientRec."Interact Code";
        Resolution."Assigned User From":=ClientRec."User ID";
        Resolution."Assigned Date From":=ClientRec."User DateTime Received";
        if ClientRec."Registry User" <> '' then begin
            Resolution."Assigned User To":=ClientRec."Registry User";
            Resolution."Assigned Date To":=ClientRec."Registry User DateTime Receive";
        end;
        Resolution."Header Status":=ClientRec.Status;
        if not Resolution.Get(ClientRec."Interact Code", Resolution."Interation Reso. Code", Resolution."Step No.")then Resolution.Insert;
        Commit;
        //CPFSMS := CPFSMS.
        //AgileSMS();
        //Result:= CPFSMS.sendMessage('CPF',ClientRec."Client Communication Phone No.",STRSUBSTNO(Text005,UPPERCASE(ClientRec."Client Log Name"),FORMAT(TODAY,0,'<Day,2> <Month Text> <Year4>'),ClientRec."Interact Code"));
        Message('Sent to Registry Successfully!');
    end;
    local procedure SendSMS()
    begin
    // CPFSMS := CPFSMS.AfricaTalk();
    //CPFSMS.AfricasTalkingMessage(string phonenumber, string clientmessage)
    end;
    procedure CheckifEditable(): Boolean begin
        // case Status of
        // Status::Logged, Status::Assigned, Status::Escalated, Status::"Awaiting 3rd Party":
        //     exit(true);
        // Status::Registry, Status::Closed:
        //     exit(false);
        // else
        exit(true);
    // end;
    end;
    procedure RecordUpdated(var ClientRec: Record "Client Interaction Header")
    var
        CreatedExitNo: Code[20];
        DocNo: Code[20];
        Resolution: Record "Resolution of Tasks Status";
        StepNo: Integer;
        CreatedRBBNo: Code[20];
        AssignedName: Text;
    begin
        if("Assigned to User" <> '')then begin
            if not Confirm(Text007)then exit;
            //Notifies the Client on the Operations Level of the Claim.
            UserDetails.Reset;
            UserDetails.SetRange("User Name", UserId);
            if UserDetails.FindFirst then if UserDetails."Full Name" <> '' then SenderName:=UserDetails."Full Name"
                else
                    SenderName:=UserId;
            if recUserSetup.Get(UserId)then;
            recUserSetup.TestField("E-Mail");
            recInteractionsSetup.Get();
            recInteractionsSetup.TestField("Operations Email");
            Clear(SMTPMail);
            if recUserSetup.Get(ClientRec."Assigned to User")then begin
                recUserSetup.CalcFields("Full Name");
                AssignedName:=recUserSetup."Full Name";
                if AssignedName = '' then AssignedName:=ClientRec."Assigned to User";
            end;
            Recipient.Add(recInteractionsSetup."Operations Email");
            SMTPMail.Create(Recipient, StrSubstNo(Text008, ClientRec."Client No.", ClientRec."Client Name"), StrSubstNo(Text009, SenderName, AssignedName, DocNo), true);
            //SMTPMail.SendWithoutError();
            // if ClientRec."Assigned to User" <> '' then
            //     ClientRec.Status := ClientRec.Status::Assigned
            // else
            //     ClientRec.Status := ClientRec.Status::"Awaiting Assignment";
            ClientRec."Datetime Claim Updated":=CreateDateTime(Today, Time);
            ClientRec."Registry User DateTime Closed":=CreateDateTime(Today, Time);
            ClientRec.Modify;
            Commit;
            //Log
            Resolution.Reset;
            Resolution.SetCurrentKey("Step No.");
            Resolution.SetRange("Interaction Header No.", ClientRec."Interact Code");
            if Resolution.FindLast then StepNo:=Resolution."Step No."
            else
                StepNo:=0;
            Resolution.Init;
            Resolution."Interaction Header No.":=ClientRec."Interact Code";
            Resolution."Interation Reso. Code":=ClientRec."Interact Code";
            Resolution."Resolution Description":='Awaiting Assignment';
            Resolution."Step No.":=StepNo + 1;
            Resolution."Assigned User From":=ClientRec."User ID";
            Resolution."Assigned Date From":=ClientRec."User DateTime Received";
            Resolution."Header Status":=Resolution."Header Status"::"Awaiting Assignment";
            Resolution."Resolution Status":=Resolution."Resolution Status"::Outstanding;
            if not Resolution.Get(ClientRec."Interact Code", Resolution."Interation Reso. Code", Resolution."Step No.")then Resolution.Insert;
            Message('Updated Successfully! 1');
        end;
        // else
        //     ClientRec.Status := ClientRec.Status::Assigned;
        ClientRec."Registry User DateTime Closed":=CreateDateTime(Today, Time);
        ClientRec.Modify;
        Commit;
        Message('Updated Successfully! 2');
    end;
    procedure UpdateIntHeaderDocCreated(CreatedDocNo: Code[20]; ClientIntHeader: Record "Client Interaction Header"; Status: Option Logged, Assigned, Escalated, "Awaiting 3rd Party", Closed, Registry, "Awaiting Assignment"; CreatedDocType: Option " ", "Membership Exit", "Risk Based Benefit")
    var
        ClientRec: Record "Client Interaction Header";
    begin
        ClientRec.Reset;
        ClientRec.SetRange("Interact Code", ClientIntHeader."Interact Code");
        if ClientRec.Find('-')then begin
            ClientRec.Status:=Status;
            ClientRec."Datetime Claim Updated":=CreateDateTime(Today, Time);
            Message('Modified Record');
            ClientRec.Modify;
            Commit;
        end;
    end;
    procedure CreateResolutionLogs(RecIntHeader: Record "Client Interaction Header"; CreatedDocNo: Code[20]; CreatedDocType: Option " ", "Membership Exit", "Risk Based Benefit"; RecUSERID: Code[30]; ResolutionDescription: Text; ResolutionStatus: Option Outstanding, Skipped, Completed; ResolutionHeaderStatus: Option Logged, Assigned, Escalated, "Awaiting 3rd Party", Closed, Registry, "Awaiting Assignment", "EFT Created", "EFT Processed", "Payment Initiated", "PV Created", "EFT Posted", "PV Posted"; RecAssignFromDateTime: DateTime)
    var
        Resolution: Record "Resolution of Tasks Status";
        StepNo: Integer;
    begin
        //Log
        Resolution.Reset;
        Resolution.SetCurrentKey("Step No.");
        Resolution.SetRange("Interaction Header No.", RecIntHeader."Interact Code");
        if Resolution.FindLast then StepNo:=Resolution."Step No."
        else
            StepNo:=0;
        Resolution.Init;
        Resolution."Interaction Header No.":=RecIntHeader."Interact Code";
        Resolution."Interation Reso. Code":=RecIntHeader."Interact Code";
        Resolution."Resolution Description":=ResolutionDescription;
        Resolution."Step No.":=StepNo + 1;
        Resolution."Document No":=CreatedDocNo;
        Resolution."Document Type":=CreatedDocType;
        Resolution."Assigned User From":=RecUSERID;
        Resolution."Assigned Date From":=RecAssignFromDateTime;
        Resolution."Header Status":=ResolutionHeaderStatus;
        Resolution."Resolution Status":=ResolutionStatus;
        if not Resolution.Get(RecIntHeader."Interact Code", Resolution."Interation Reso. Code", Resolution."Step No.")then Resolution.Insert;
    //MESSAGE('Created Resolution: Step::%1',StepNo);
    end;
    procedure InsertInitialLog(CaseDoc: Record "Client Interaction Header")
    var
        Resolution: Record "Resolution of Tasks Status";
        StepNo: Integer;
    begin
        //Insert Log
        Resolution.Reset;
        Resolution.SetCurrentKey("Step No.");
        Resolution.SetRange("Interaction Header No.", CaseDoc."Interact Code");
        if Resolution.FindLast then StepNo:=Resolution."Step No.";
        Resolution.Reset;
        Resolution.SetRange("Interaction Header No.", CaseDoc."Interact Code");
        Resolution.SetRange("Header Status", Resolution."Header Status"::Logged);
        if not Resolution.FindFirst then begin
            Resolution.Init;
            Resolution."Interaction Header No.":=CaseDoc."Interact Code";
            Resolution."Interation Reso. Code":=CaseDoc."Interact Code";
            Resolution."Step No.":=StepNo + 1;
            Resolution."Resolution Description":='Initial Log';
            Resolution."Document No":=CaseDoc."Interact Code";
            Resolution."Assigned User From":=UserId;
            Resolution."Assigned Date From":=CreateDateTime(Today, Time);
            Resolution."Assigned User To":=UserId;
            Resolution."Assigned Date To":=CreateDateTime(Today, Time);
            Resolution."Header Status":=Resolution."Header Status"::Logged;
            Resolution."Resolution Status":=Resolution."Resolution Status"::Completed;
            if not Resolution.Get(CaseDoc."Interact Code", Resolution."Interation Reso. Code", Resolution."Step No.")then Resolution.Insert;
        end;
    end;
    procedure CloseResolutionLog(CaseDoc: Record "Client Interaction Header"; StepNo: Integer; RecUserID: Code[20]; RecUserIDCloseDateTime: DateTime)
    var
        Resolution: Record "Resolution of Tasks Status";
    begin
        //Insert Log
        Resolution.Reset;
        Resolution.SetCurrentKey("Step No.");
        Resolution.SetRange("Interaction Header No.", CaseDoc."Interact Code");
        Resolution.SetRange("Step No.", StepNo);
        if Resolution.FindLast then begin
            Resolution."Assigned User From":=RecUserID;
            Resolution."Assigned Date From":=RecUserIDCloseDateTime;
            //    Resolution."Assigned User To":=USERID;
            //    Resolution."Assigned Date To":=CREATEDATETIME(TODAY,TIME);
            Resolution."Resolution Status":=Resolution."Resolution Status"::Completed;
            Resolution.Modify;
        end;
    end;
    procedure NotifyOperationsOnCreatedDoc(var ClientRec: Record "Client Interaction Header")
    var
        CreatedExitNo: Code[20];
        Resolution: Record "Resolution of Tasks Status";
        StepNo: Integer;
        CreatedRBBNo: Code[20];
        AssignedName: Text;
    begin
        // IF NOT CONFIRM(Text007) THEN
        //  EXIT;
        // //Creates a Member Exit claim in the system
        // IF "Interaction Type"<>"Interaction Type"::"Risk Based Benefits" THEN
        // CreatedExitNo:=CreateMembershipExit(Rec)
        // ELSE
        // CreatedRBBNo:=CreateRBBPayment(Rec);
        //Notifies the Client on the Operations Level of the Claim.
        UserDetails.Reset;
        UserDetails.SetRange("User Name", UserId);
        if UserDetails.FindFirst then if UserDetails."Full Name" <> '' then SenderName:=UserDetails."Full Name"
            else
                SenderName:=UserId;
        if recUserSetup.Get(UserId)then;
        recUserSetup.TestField("E-Mail");
        recInteractionsSetup.Get();
        recInteractionsSetup.TestField("Operations Email");
        Clear(SMTPMail);
        if recUserSetup.Get(ClientRec."Assigned to User")then begin
            recUserSetup.CalcFields("Full Name");
            AssignedName:=recUserSetup."Full Name";
            if AssignedName = '' then AssignedName:=ClientRec."Assigned to User";
        end;
        Recipient.Add(recInteractionsSetup."Operations Email");
        SMTPMail.Create(Recipient, StrSubstNo(Text008, ClientRec."Client No.", ClientRec."Client Name"), StrSubstNo(Text009, SenderName, AssignedName), true);
        Email.Send(SMTPMail);
        Commit;
        //Log
        // Resolution.RESET;
        // Resolution.SETCURRENTKEY("Step No.");
        // Resolution.SETRANGE("Resolution Code",ClientRec."Interact Code");
        // IF Resolution.FINDLAST THEN
        //  StepNo:=Resolution."Step No."
        // ELSE
        //  StepNo:=0;
        //
        // Resolution.INIT;
        // Resolution."Resolution Code":=ClientRec."Interact Code";
        // Resolution."Interation Reso. Code":=ClientRec."Interact Code";
        // Resolution."Resolution Description":='Awaiting Assignment';
        // Resolution."Step No.":=StepNo+1;
        // IF "Interaction Type"<>"Interaction Type"::"Risk Based Benefits" THEN
        //  Resolution."Document No":=CreatedExitNo
        // ELSE
        //  Resolution."Document No":=CreatedRBBNo;
        // Resolution."Assigned User From":=ClientRec."User ID";
        // Resolution."Assigned Date From":=ClientRec."User DateTime Received";
        // Resolution."Header Status":=Resolution."Header Status"::"Awaiting Assignment";
        // Resolution."Resolution Status":=Resolution."Resolution Status"::Outstanding;
        // IF NOT Resolution.GET(ClientRec."Interact Code",Resolution."Interation Reso. Code",Resolution."Step No.") THEN
        //  Resolution.INSERT;
        Message('Operations Notified Successfully!');
    end;
    procedure AtRegistry(): Boolean begin
    // if (Status = Status::Registry) then
    //     exit(true);
    end;
    procedure AssignClaim(var ClientRec: Record "Client Interaction Header")
    begin
        if not Confirm(Text012, false, ClientRec."Assigned to User")then exit;
        UserDetails.Reset;
        UserDetails.SetRange("User Name", UserId);
        if UserDetails.FindFirst then if UserDetails."Full Name" <> '' then SenderName:=UserDetails."Full Name"
            else
                SenderName:=UserId;
        if recUserSetup.Get(UserId)then;
        recUserSetup.TestField("E-Mail");
        ClientRec.TestField("Assigned to User");
        if recUserSetup1.Get(ClientRec."Assigned to User")then;
        recUserSetup1.TestField("E-Mail");
        UserDetails.Reset;
        UserDetails.SetRange("User Name", UserId);
        if UserDetails.FindFirst then if UserDetails."Full Name" <> '' then ToName:=UserDetails."Full Name"
            else
                ToName:=ClientRec."Assigned to User";
        Clear(SMTPMail);
        Recipient.Add(recUserSetup1."E-Mail");
        SMTPMail.Create(Recipient, StrSubstNo(Text013, ClientRec."Client No.", ClientRec."Client Name"), StrSubstNo(Text014, ToName, ClientRec."Assign Remarks", SenderName), true);
        Email.Send(SMTPMail);
        // ClientRec.Status := ClientRec.Status::Assigned;
        ClientRec."Datetime Claim Assigned":=CreateDateTime(Today, Time);
        ClientRec.Modify;
        Message('Assigned Successfully!');
    end;
    procedure Assigned(): Boolean begin
    // if (Status = Status::"Awaiting Assignment") then
    //     exit(true);
    end;
    procedure Cleared(): Boolean begin
    // if (Status = Status::Assigned) then
    //     exit(true);
    end;
    procedure CheckIfClientDetailsEditable(): Boolean begin
        // if Status = Status::Logged then
        //     exit(true)
        // else
        exit(false);
    end;
    procedure CheckIfClientNoVisible(): Boolean begin
        case "Client Type" of "Client Type"::" ": exit(false);
        else
            exit(true);
        end;
    end;
    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Client Interaction Header", "Interact Code", FieldNumber, ShortcutDimCode);
        Modify;
    end;
    procedure UpdateRegistryUserDetails(CaseDoc: Record "Client Interaction Header")
    var
        ClientIntRec: Record "Client Interaction Header";
        Resolution: Record "Resolution of Tasks Status";
        StepNo: Integer;
    begin
        ClientIntRec.Reset;
        ClientIntRec.SetRange("Interact Code", CaseDoc."Interact Code");
        if ClientIntRec.FindFirst then begin
            ClientIntRec."Registry User":=UserId;
            ClientIntRec."Registry User DateTime Receive":=CreateDateTime(Today, Time);
            ClientIntRec.Modify;
            StepNo:=0;
            //Insert Log
            Resolution.Reset;
            Resolution.SetCurrentKey("Step No.");
            Resolution.SetRange("Interaction Header No.", CaseDoc."Interact Code");
            if Resolution.FindLast then StepNo:=Resolution."Step No.";
            Resolution.Reset;
            Resolution.SetRange("Interaction Header No.", CaseDoc."Interact Code");
            Resolution.SetRange("Header Status", CaseDoc.Status);
            if not Resolution.FindFirst then begin
                Resolution.Init;
                Resolution."Interaction Header No.":=CaseDoc."Interact Code";
                Resolution."Interation Reso. Code":='';
                Resolution."Step No.":=StepNo + 1;
                Resolution."Document No":=CaseDoc."Interact Code";
                Resolution."Assigned User From":=CaseDoc."User ID";
                Resolution."Assigned Date From":=CaseDoc."User DateTime Received";
                if CaseDoc."Registry User" <> '' then begin
                    Resolution."Assigned User To":=CaseDoc."Registry User";
                    Resolution."Assigned Date To":=CaseDoc."Registry User DateTime Receive";
                end
                else
                    Resolution."Assigned User To":=UserId;
                Resolution."Assigned Date To":=CreateDateTime(Today, Time);
                Resolution."Header Status":=CaseDoc.Status;
                if not Resolution.Get(CaseDoc."Interact Code", Resolution."Interation Reso. Code", Resolution."Step No.")then Resolution.Insert;
            end
            else
            begin
                Resolution."Interaction Header No.":=CaseDoc."Interact Code";
                Resolution."Document No":=CaseDoc."Interact Code";
                Resolution."Assigned User From":=CaseDoc."User ID";
                Resolution."Assigned Date From":=CaseDoc."User DateTime Received";
                Resolution."Assigned User To":=UserId;
                Resolution."Assigned Date To":=CreateDateTime(Today, Time);
                Resolution.Modify;
            end;
        end;
    end;
    procedure CloseClaimLog(CaseDoc: Record "Client Interaction Header")
    var
        ClientIntRec: Record "Client Interaction Header";
        Resolution: Record "Resolution of Tasks Status";
        StepNo: Integer;
    begin
        ClientIntRec.Reset;
        ClientIntRec.SetRange("Interact Code", CaseDoc."Interact Code");
        if ClientIntRec.FindFirst then begin
            // ClientIntRec.Status := ClientIntRec.Status::Closed;
            ClientIntRec."Closed By":=UserId;
            ClientIntRec."Closed DateTime":=CreateDateTime(Today, Time);
            ClientIntRec.Modify;
            StepNo:=0;
            //Insert Log
            Resolution.Reset;
            Resolution.SetCurrentKey("Step No.");
            Resolution.SetRange("Interaction Header No.", CaseDoc."Interact Code");
            if Resolution.FindLast then StepNo:=Resolution."Step No.";
            Resolution.Reset;
            Resolution.SetRange("Interaction Header No.", CaseDoc."Interact Code");
            Resolution.SetRange("Header Status", Resolution."Header Status"::Closed);
            if not Resolution.FindFirst then begin
                Resolution.Init;
                Resolution."Interaction Header No.":=CaseDoc."Interact Code";
                Resolution."Interation Reso. Code":='Closed';
                Resolution."Step No.":=StepNo + 1;
                Resolution."Document No":=CaseDoc."Interact Code";
                Resolution."Assigned User From":=CaseDoc."User ID";
                Resolution."Assigned Date From":=CaseDoc."User DateTime Received";
                Resolution."Assigned User To":=UserId;
                Resolution."Assigned Date To":=CreateDateTime(Today, Time);
                Resolution."Header Status":=Resolution."Header Status"::Closed;
                Resolution."Resolution Status":=Resolution."Resolution Status"::Completed;
                if not Resolution.Get(CaseDoc."Interact Code", Resolution."Interation Reso. Code", Resolution."Step No.")then Resolution.Insert;
            end
            else
            begin
                Resolution."Interaction Header No.":=CaseDoc."Interact Code";
                Resolution."Document No":=CaseDoc."Interact Code";
                Resolution."Assigned User From":=CaseDoc."User ID";
                Resolution."Assigned Date From":=CaseDoc."User DateTime Received";
                Resolution."Assigned User To":=UserId;
                Resolution."Assigned Date To":=CreateDateTime(Today, Time);
                Resolution."Header Status":=ClientIntRec.Status;
                Resolution.Modify;
            end;
        end;
    end;
    procedure EscaletAndAssignInteraction(var RecClientIntHeader: Record "Client Interaction Header")
    begin
        if not Confirm(Text016, false, RecClientIntHeader."Escalation To User ID")then exit;
        UserDetails.Reset;
        UserDetails.SetRange("User Name", UserId);
        if UserDetails.FindFirst then if UserDetails."Full Name" <> '' then SenderName:=UserDetails."Full Name"
            else
                SenderName:=UserId;
        if recUserSetup.Get(UserId)then;
        recUserSetup.TestField("E-Mail");
        RecClientIntHeader.TestField("Escalation To User ID");
        if recUserSetup1.Get(RecClientIntHeader."Escalation To User ID")then;
        recUserSetup1.TestField("E-Mail");
        UserDetails.Reset;
        UserDetails.SetRange("User Name", RecClientIntHeader."Escalation To User ID");
        if UserDetails.FindFirst then if UserDetails."Full Name" <> '' then ToName:=UserDetails."Full Name"
            else
                ToName:=RecClientIntHeader."Escalation To User ID";
        Clear(SMTPMail);
        Recipient.Add(recUserSetup1."E-Mail");
        SMTPMail.Create(Recipient, StrSubstNo(Text017, RecClientIntHeader."Interact Code"), StrSubstNo(Text018, ToName, RecClientIntHeader."Escalation Remarks", SenderName), true);
        Email.Send(SMTPMail);
        // RecClientIntHeader.Status := RecClientIntHeader.Status::Escalated;
        RecClientIntHeader."Escalation Clock":=CreateDateTime(Today, Time);
        RecClientIntHeader."Escalation Level No.":=RecClientIntHeader."Escalation Level No." + 1;
        RecClientIntHeader.Modify;
        Message('Assigned Successfully!');
    end;
    procedure GetPreviousStepNo(CaseDoc: Record "Client Interaction Header"): Integer var
        Resolution: Record "Resolution of Tasks Status";
    begin
        Resolution.Reset;
        Resolution.SetCurrentKey("Step No.");
        Resolution.SetRange("Interaction Header No.", CaseDoc."Interact Code");
        if Resolution.FindLast then exit(Resolution."Step No.");
    end;
    procedure CountInteractions(CountStatus: Option Logged, Assigned, Escalated, "Awaiting 3rd Party", Closed, Registry, "Awaiting Assignment"): Integer var
        ClientRec: Record "Client Interaction Header";
    begin
        ClientRec.Reset;
        ClientRec.SetRange(Status, CountStatus);
        exit(ClientRec.Count);
    end;
}
