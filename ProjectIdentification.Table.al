table 50683 ProjectIdentification
{
    DrillDownPageID = ProjectIdentification;
    LookupPageID = ProjectIdentification;

    fields
    {
        field(1; "Project No."; Code[50])
        {
            NotBlank = false;
            Tablerelation = Projectman where("project approval status"=const(approved));

            Trigger onvalidate();
            var
                Projectman: Record Projectman;
            begin
                Projectman.get("Project No.");
                "Project Name":=Projectman."Project Name";
                "Type of Project":=projectman."Type of Project";
                "Client code":=projectman."Client Code";
                "Contractor name":=projectman."Contractor Name";
                "project approval status":=projectman."Project Approval Status";
                "project start date":=Projectman."Project Start Date";
                "Project Duration":=projectman."Project Duration";
                "Project End Date":=Projectman."Project End Date";
                "Project Manager Code":=Projectman."Project Manager Code";
                "contact person":=Projectman."Project Manager name";
                "Project Estimated Cost":=Projectman."Amount LCY";
                "Project Actual Cost":=Projectman."Project Actual Cost";
                "Project Manager Email":=Projectman."Project Manager Email";
                "Project Manager Contact":=Projectman."Project Manager Contact";
                "Project Manager Contact2":=Projectman."Project Manager Contact2";
                "project Budget":=projectman."Amount LCY";
            end;
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
            // "Project End Date" := CalcDate("Project Duration", "Project Start Date");
            end;
        }
        field(8; "Project Start Date"; Date)
        {
        }
        field(9; "Project End Date"; Date)
        {
        }
        field(5; "Project Manager Code"; code[20])
        {
            TableRelation = Employee."No.";

            trigger onvalidate()
            var
                emptable: record Employee;
            begin
            // emptable.get("Project manager code");
            // "Project Manager Name" := emptable."First Name" + ' ' + emptable."Middle Name" + ' ' + emptable."Last Name";
            end;
        }
        field(575; "Project Manager Name"; Text[60])
        {
        }
        field(577; "Project Manager Email"; Text[60])
        {
            caption = 'Contact Person Enail';
        }
        field(578; "Project Manager Contact"; Text[60])
        {
            Caption = 'Mobile Number';
        }
        field(579; "Project Manager Contact2"; Text[60])
        {
            Caption = 'Mobile Number 2';
        }
        field(139; "Project Estimated Cost"; Decimal)
        {
            //DataClassification = ToBeClassified;
            Editable = false;
        // fieldclass = flowfield;
        //CalcFormula = sum("Project Tasks Mgmt".ProjectEstimatedCostPerTask where("project no." = field("project no.")));
        }
        field(140; "Project Actual Cost"; Decimal)
        {
            // DataClassification = ToBeClassified;
            Editable = false;
            fieldclass = flowfield;
            CalcFormula = sum("Project Tasks Mgmt"."MileStone Actual Cost" where("project no."=field("project no.")));
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
            //CustomerRec.get("client code");
            //"Contractor Name" := CustomerRec."Search Name";
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
            //"Consultancy Fee" := "Contract Value" - "Provisional Sum";
            end;
        }
        field(39; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
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
            //"Consultancy Fee" := "Contract Value" - "Provisional Sum";
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
        field(56; NeedContent; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(57; PurposeCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(58; PurposeContent; Text[1000])
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
        field(63; DesignActivity; Text[1000])
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
        field(67; EvaluationContent; Text[1000])
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
        field(70; "Mode of Dissemination"; Text[1000])
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
        field(77; SustainabilityContent; text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Type of Project"; TEXT[50])
        {
            DataClassification = ToBeClassified;
            Tablerelation = ProjectSetupType."Project Type";
        }
        field(80; "Project Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(81; Initiated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Under Implementation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Under Monitoring & Evaluation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Project Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Project Under Review"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Background/Context"; text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Objective"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Data Collection"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Sampling"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Limitations"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(117; "Logistics/Support"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Preliminary Findings"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Period"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(123; userid; Text[50])
        {
            DataClassification = ToBeClassified;
        //Caption
        }
        field(143; "Submitted By"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        //Caption
        }
        field(144; "Distribution List"; Text[1000])
        {
            DataClassification = ToBeClassified;
        //Caption
        }
        field(124; "Current Status"; option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Work in Progress,Complete,Overdue';
            OptionMembers = "Work in Progress", Complete, Overdue;
        }
        field(125; "Previous Status"; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(127; "Overal Project Status"; option)
        {
            //DataClassification = ToBeClassified;
            OptionCaption = 'Work in Progress,Complete,Overdue';
            OptionMembers = "Work in Progress", Complete, Overdue;
            caption = 'Overall Project Status';
        }
        field(147; "Overal Status Summary"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Overall Status Summary';
        }
        field(128; "Schedule"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(148; "Schedule Perfomance Text"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(129; "Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(149; "Budget Perfomance"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Project Risk"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High, Medium, Low;
        }
        field(150; "Project Risk Summary"; Text[1000])
        {
        //DataClassification = ToBeClassified;
        }
        field(141; "AccomplishmentsSincelast"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Accomplishment since Last Report';
        }
        field(132; "UpcomingSteps"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upcoming/Next Steps';
        }
        field(133; "Key Issues"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Key Risks that may Affect The Project';
        }
        field(153; "Key Issues Current"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Key Risks Currently Affecting Project';
        }
        field(135; "Upcoming MileStones"; Text[50])
        {
        }
        field(137; "Completion Dates"; Date)
        {
            DataClassification = ToBeClassified;
        //List of Upcoming Tasks
        }
        field(160; "Project Relevance"; Text[1000])
        {
        }
        field(161; "Project Performance"; Text[1000])
        {
        }
        field(162; "Substantive Contribution"; Text[1000])
        {
        }
        field(163; "Audit Comments"; Text[1000])
        {
        }
        field(164; "Accounting Period"; Date)
        {
            TableRelation = "Accounting Period";
            DataClassification = ToBeClassified;
        }
        field(50000; "Invoice Created"; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50001; "Project Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Direct Posting"=const(true));
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
        // if "Project No." = '' then begin
        //     Purchsetup.Get;
        //     PurchSetup.TestField("Project Mgt Nos");
        //     NoSeriesMgt.InitSeries(PurchSetup."Project Mgt Nos", xRec."No. Series", 0D, "Project No.", "No. Series");
        // end;
        "Created By":=UserId + ' ' + ' on ' + Format(CreateDateTime(Today, Time));
        "Submitted By":=userid;
        "Date Created":=Today;
        "User ID":=UserId;
    end;
    trigger OnModify()
    begin
        "Last Modified By":=UserId + ' ' + ' on ' + Format(CreateDateTime(Today, Time));
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Vendor: Record Vendor;
    GlAccount: Record "G/L Account";
    TEXT000: Label 'Block this Contract %1?';
    TEXT001: Label 'Unblock Contract %1?';
    //HRSetup: Record "Human Resources Setup";
    UserSetup: Record "User Setup";
    [Scope('Cloud')]
    procedure CalcBal()
    begin
    // Balance:="Original Contract Price"-"Amount Paid";
    // VALIDATE(Balance);
    end;
}
