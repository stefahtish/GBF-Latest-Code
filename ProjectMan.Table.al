table 50665 ProjectMan
{
    fields
    {
        field(1; "Project No."; Code[50])
        {
            NotBlank = false;
        }
        field(2; "Project Name"; Text[250])
        {
            NotBlank = true;
            Caption = 'Project Title';
        }
        field(6; "Project Status"; Option)
        {
            OptionCaption = 'Open, Work in Progress, Work in Progress (Overdue), Closed';
            OptionMembers = Open, "Work in Progress", "Work in Progress (Overdue)", Closed;
        }
        field(146; "Project Approval Status"; Option)
        {
            OptionCaption = 'Open ,Pending Approval,Approved,Cancelled,Rejected';
            OptionMembers = Open, "Pending Approval", Approved, Cancelled, Rejected;
        }
        field(26; "Project Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                "Project End Date":=CalcDate("Project Duration", "Project Start Date");
            end;
        }
        field(8; "Project Start Date"; Date)
        {
        }
        field(9; "Project End Date"; Date)
        {
        }
        field(83; Dim3; Text[250])
        {
        }
        field(261; "Actual Project Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                "Actual Project End Date":=CalcDate("Actual Project Duration", "Actual Project Start Date");
            end;
        }
        field(81; "Actual Project Start Date"; Date)
        {
        }
        field(91; "Actual Project End Date"; Date)
        {
        }
        field(5; "Project Manager Code"; code[20])
        {
            TableRelation = Employee."No.";

            trigger onvalidate()
            var
                emptable: record Employee;
            begin
                emptable.get("Project manager code");
                "Project Manager Name":=emptable."First Name" + ' ' + emptable."Middle Name" + ' ' + emptable."Last Name";
                "project manager email":=emptable."E-Mail";
                "Project Manager Contact":=emptable."Phone no.";
                "project manager contact2":=emptable."Mobile Phone No.";
            end;
        }
        field(576; "Project Manager Name"; Text[60])
        {
        }
        field(577; "Project Manager Email"; Text[60])
        {
        }
        field(578; "Project Manager Contact"; Text[60])
        {
        }
        field(579; "Project Manager Contact2"; Text[60])
        {
        }
        field(139; "Project Estimated Cost"; Decimal)
        {
        // fieldclass = flowfield;
        //CalcFormula = sum("Project Tasks Mgmt".ProjectEstimatedCostPerTask where("project no." = field("project no.")));
        }
        field(140; "Project Actual Cost"; Decimal)
        {
        // DataClassification = ToBeClassified;
        // Editable = false;
        // fieldclass = flowfield;
        // CalcFormula = sum("Project Tasks Mgmt".ProjectActualCostPerTask where("project no." = field("project no.")));
        }
        field(10; "Tender no."; Code[100])
        {
        }
        field(11; "Original Contract Price"; Decimal)
        {
            Description = 'Original Price';

            trigger OnValidate()
            begin
            // IF "Revised Contract Price" = 0 THEN
            // BEGIN
            //    Balance:="Original Contract Price"-"Amount Paid"-Contigencies;
            // END ELSE
            // BEGIN
            //    Balance:="Revised Contract Price"-"Amount Paid"-Contigencies;
            // END;
            end;
        }
        field(12; "Cutomer Code"; Code[30])
        {
        // TableRelation = Vendor."No." WHERE("Vendor Posting Group" = CONST('CLIENT'),
        //                                      Blocked = FILTER(" "));
        // Caption = 'Client Code';
        // trigger OnValidate()
        // begin
        //     Vendor.RESET;
        //     IF Vendor.GET() THEN BEGIN
        //         "Contractor Name" := Vendor.Name;
        //     END ELSE BEGIN
        //         "Contractor Name" := '';
        //     END;
        // end;
        }
        field(131; "Client Code"; code[50])
        {
            Caption = 'Project Sponsor Code';
            tablerelation = customer."No." where("customertype"=filter(normal));

            trigger OnValidate()
            Var
                CustomerRec: record customer;
            begin
                CustomerRec.get("client code");
                "Contractor Name":=CustomerRec."Search Name";
            end;
        }
        field(13; "Contractor Name"; Text[100])
        {
            Caption = 'Project Sponsor Name';
        }
        field(14; "No. Series"; Code[30])
        {
        }
        field(15; "Amount Paid"; Decimal)
        {
            FieldClass = Normal;
        }
        field(16; Balance; Decimal)
        {
            Caption = 'Running Balance';
        }
        field(17; "Project Code"; Code[30])
        {
            trigger OnValidate()
            begin
            //    GlAccount.RESET();
            //   GlAccount.GET("Project Code");
            //   "Project Name":=GlAccount.Name;
            end;
        }
        // field(18; "Project Name"; Text[100])
        // {
        // }
        field(19; "Recorgised Liablity"; Decimal)
        {
            FieldClass = Normal;
        }
        field(20; "Revised Price"; Decimal)
        {
        }
        field(21; "Previous Gross Work Done"; Decimal)
        {
            Description = 'Contract Certificates that have been fully approved or releaseds';
        }
        field(22; "Previous Retention"; Decimal)
        {
            Description = 'Sumation of all approved CC divide by 10%';
        }
        field(23; "Amount of Advance Payment"; Decimal)
        {
            Description = 'Total Summation advance payment for each approved certificate';
        }
        field(24; "Created By"; Text[100])
        {
            Editable = false;
        }
        field(25; "Last Modified By"; Text[100])
        {
        }
        field(28; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(29; Contigencies; Decimal)
        {
            trigger OnValidate()
            begin
            //VALIDATE("Original Contract Price");
            end;
        }
        field(30; "Progress of Work"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = , "Not started", Progress, Completed;
        }
        field(31; "Date of Certificate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Title Of Assignment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Amount Due In the Cert(VAT)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; Client; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Contract Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Consultancy Fee":="Contract Value" - "Provisional Sum";
            end;
        }
        field(39; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CurrencyRec: Record Currency;
                CurrExchRate: Record "Currency Exchange Rate";
            begin
                CurrencyRec.InitRoundingPrecision;
                if "Currency Code" = '' then "Amount LCY":=Round(Amount, CurrencyRec."Amount Rounding Precision")
                else
                    "Amount LCY":=Round(CurrExchRate.ExchangeAmtFCYToLCY("Date Created", "Currency Code", Amount, CurrExchRate.ExchangeRate("Date Created", "Currency Code")), CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(42; "Contractor Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Last Payment Certificate"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Provisional Sum"; Decimal)
        {
            FieldClass = Normal;

            trigger OnValidate()
            begin
                "Consultancy Fee":="Contract Value" - "Provisional Sum";
            end;
        }
        field(45; "Consultancy Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(47; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Tablerelation = "User Setup";
        }
        field(48; "Contact Person"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Phone Number"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Email"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        //Additional Deatails in Regards to Project Management Modules.
        field(53; Abstractcode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54; AbstractContent; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(55; NeedCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(56; NeedContent; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(57; PurposeCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(58; PurposeContent; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(59; PurposeGoal; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60; PurposeOutcome; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        //project Design
        field(61; DesignCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(62; DesignContent; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(63; DesignActivity; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(64; DesignGoal; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Statement of Purpose".Goal;
        }
        field(65; DesignOutcome; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        //Evaluation 
        field(66; EvaluationCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(67; EvaluationContent; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Unit of Measure"; code[40])
        {
            DataClassification = ToBeClassified;
        }
        //Dissemination is
        field(69; Content; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Mode of Dissemination"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Mode of Marketing"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Target Group"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Team Member Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Qualification"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Experience"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        //Sustainability Planning
        field(76; SustainabiliyCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(77; SustainabilityContent; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Type of Project"; TEXT[50])
        {
            DataClassification = ToBeClassified;
            Tablerelation = ProjectSetupType."Project Type";

            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
            begin
                GLSetup.Get();
                "Shortcut Dimension 3 Code":=GLSetup."Shortcut Dimension 3 Code";
            end;
        }
        // field(80; "Shortcut Dimension 3 Code"; code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Activity Budget Code';
        //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        //     trigger OnValidate()
        //     begin
        //         ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
        //     end;
        // }
        field(82; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-')then Dim3:=DimVal.Name end;
        }
        field(84; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value" where("Dimension Code"=field("Shortcut Dimension 3 Code"));
        }
        field(85; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Dimension Value"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value" where("Dimension Code"=field("Shortcut Dimension 3 Code"));
        }
        field(50039; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                if Amount <> 0 then Validate(Amount);
            end;
        }
        field(50042; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Project No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Project No.", "Project Name")
        {
        }
    }
    trigger OnInsert()
    begin
        if "Project No." = '' then begin
            Purchsetup.Get;
            PurchSetup.TestField("Project Mgt Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Project Mgt Nos", xRec."No. Series", 0D, "Project No.", "No. Series");
        end;
        "Created By":=UserId + ' ' + ' on ' + Format(CreateDateTime(Today, Time));
        "Date Created":=Today;
        "User ID":=UserId;
    end;
    trigger OnModify()
    begin
        "Last Modified By":=UserId + ' ' + ' on ' + Format(CreateDateTime(Today, Time));
    end;
    var Salheader: page "InterBank Transfer";
    PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Vendor: Record Vendor;
    GlAccount: Record "G/L Account";
    TEXT000: Label 'Block this Contract %1?';
    TEXT001: Label 'Unblock Contract %1?';
    //HRSetup: Record "Human Resources Setup";
    UserSetup: Record "User Setup";
    DimVal: Record "Dimension Value";
    // procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // var
    //     OldDimSetID: Integer;
    //     GLBudget: Record "G/L Budget Entry";
    //     NewDimSetID: Integer;
    //     PaymentRec: Record Payments;
    // begin
    //     OldDimSetID := "Dimension Set ID";
    //     if FieldNumber = 3 then
    //         "Shortcut Dimension 3 Code" := ShortcutDimCode;
    //     DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    //     IF ("No." <> '') THEN
    //         MODIFY;
    //     IF (OldDimSetID <> "Dimension Set ID") AND (("No." <> '')) THEN BEGIN
    //         MODIFY;
    //         //IF SalesLinesExist THEN
    //         //UpdateAllLineDim("Dimension Set ID",OldDimSetID);
    //     END;
    //     //G/L Account
    //     if FieldNumber = 3 then begin
    //         GLSetup.Get;
    //         GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
    //         GLBudget.SetRange("Budget Dimension 3 Code", ShortcutDimCode);
    //         if GLBudget.Find('-') then begin
    //             if "Account Type" <> "Account Type"::"G/L Account" then begin
    //                 "Account Type" := "Account Type"::"G/L Account";
    //             end;
    //             if "Account No" <> GLBudget."G/L Account No." then begin
    //                 "Account No" := GLBudget."G/L Account No.";
    //                 Validate("Account No");
    //             end;
    //         end;
    //     end;
    // end;
    // procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    // begin
    //     DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    //end;
    [Scope('Cloud')]
    procedure CalcBal()
    begin
    // Balance:="Original Contract Price"-"Amount Paid";
    // VALIDATE(Balance);
    end;
}
