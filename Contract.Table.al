table 50531 Contract
{
    DrillDownPageID = Contract2_List;
    LookupPageID = Contract2_List;

    fields
    {
        field(1; "Contract No."; Code[50])
        {
            NotBlank = false;
        }
        field(2; "Contract Name"; Text[250])
        {
            NotBlank = true;
        }
        field(3; "Contract Category"; Option)
        {
            OptionCaption = ' ,Consultants,Work';
            OptionMembers = " ", Consultants, Work;
        }
        field(4; "Contract Type"; Option)
        {
            OptionMembers = " ", Single;
        }
        field(5; "Project Manager"; Text[100])
        {
        }
        field(6; Status; Option)
        {
            OptionCaption = 'Initiated ,On Going,Completed';
            OptionMembers = "Initiated ", "On Going", Completed;
        }
        field(7; Blocked; Boolean)
        {
        }
        field(8; "Date of commencement"; Date)
        {
            trigger OnValidate()
            begin
            // IF "Contract Duration (Days)" = 0 THEN
            // BEGIN
            //    "Ending Date":=0D;
            // END ELSE
            // BEGIN
            //    "Ending Date":="Starting Date" + "Contract Duration (Days)";
            // END;
            end;
        }
        field(9; "Date of Completion"; Date)
        {
            trigger OnValidate()
            begin
            //    VALIDATE("Original Contract Price");
            end;
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
        field(12; "Contractor Code"; Code[30])
        {
            TableRelation = Vendor."No." WHERE("Vendor Posting Group"=CONST('CONTRACTOR'), Blocked=FILTER(" "));

            trigger OnValidate()
            begin
            //   Vendor.RESET;
            //   IF Vendor.GET("Contractor Code") THEN
            //   BEGIN
            //      "Contractor Name":=Vendor.Name;
            //   END ELSE
            //   BEGIN
            //      "Contractor Name":='';
            //   END;
            end;
        }
        field(13; "Contractor Name"; Text[50])
        {
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
        field(18; "Project Name"; Text[100])
        {
        }
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
            Description = 'Total Sumation advance payment for each approved certificate';
        }
        field(24; "Created By"; Text[100])
        {
            Editable = false;
        }
        field(25; "Last Modified By"; Text[100])
        {
        }
        field(26; "Contract Duration (Days)"; Integer)
        {
            trigger OnValidate()
            begin
            //VALIDATE("Starting Date");
            end;
        }
        field(28; "Date Created"; Date)
        {
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
        field(33; "Total Contract Amount"; Decimal)
        {
            CalcFormula = Sum(Certificate_Consol.Amount WHERE("Contract No."=FIELD("Contract No.")));
            FieldClass = FlowField;
        }
        field(34; "Total Delivarable Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Schedule"."Paid Amount" WHERE("Contract No."=FIELD("Contract No.")));
            FieldClass = FlowField;
        }
        field(35; "Total Approx of prov Sum"; Decimal)
        {
            CalcFormula = Sum("Cert_Provi Sum".Amount WHERE("Conract No."=FIELD("Contract No.")));
            FieldClass = FlowField;
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
        }
        field(40; TotalPaidAmount; Decimal)
        {
            CalcFormula = Sum("Payment Schedule".Amount WHERE("Contract No."=FIELD("Contract No."), Paid=CONST(true)));
            FieldClass = FlowField;
        }
        field(41; "IPC No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Schedule"."Schedule No." WHERE("Contract No."=FIELD("Contract No."));
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
        }
    }
    keys
    {
        key(Key1; "Contract No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Contract No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Contract No");
            NoSeriesMgt.InitSeries(HRSetup."Contract No", xRec."No. Series", 0D, "Contract No.", "No. Series");
        end;
        "Created By":=UserId + ' ' + ' on ' + Format(CreateDateTime(Today, Time));
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
    HRSetup: Record "Human Resources Setup";
    UserSetup: Record "User Setup";
    [Scope('Cloud')]
    procedure CalcBal()
    begin
    // Balance:="Original Contract Price"-"Amount Paid";
    // VALIDATE(Balance);
    end;
}
