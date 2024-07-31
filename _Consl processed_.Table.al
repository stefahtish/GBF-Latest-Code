table 50541 "Consl processed"
{
    fields
    {
        field(1; "Contract No."; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(2; "Contract Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Contract Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Consultants,Work';
            OptionMembers = " ", Consultants, Work;
        }
        field(4; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Single;
        }
        field(5; "Project Manager"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Initiated ,On Going,Completed';
            OptionMembers = "Initiated ", "On Going", Completed;
        }
        field(7; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date of commencement"; Date)
        {
            DataClassification = ToBeClassified;

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
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            //    VALIDATE("Original Contract Price");
            end;
        }
        field(10; "Tender no."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Original Contract Price"; Decimal)
        {
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
        }
        field(14; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Project Code"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            //    GlAccount.RESET();
            //   GlAccount.GET("Project Code");
            //   "Project Name":=GlAccount.Name;
            end;
        }
        field(18; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Recorgised Liablity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Revised Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Previous Gross Work Done"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Contract Certificates that have been fully approved or releaseds';
        }
        field(22; "Previous Retention"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Sumation of all approved CC divide by 10%';
        }
        field(23; "Amount of Advance Payment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Total Sumation advance payment for each approved certificate';
        }
        field(24; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Last Modified By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Contract Duration (Days)"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            //VALIDATE("Starting Date");
            end;
        }
        field(28; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Contigencies; Decimal)
        {
            DataClassification = ToBeClassified;

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
            CalcFormula = Sum(Cert_Delivarable.Amount WHERE("Conract No."=FIELD("Contract No.")));
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
        }
        field(39; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; TotalPaidAmount; Decimal)
        {
            CalcFormula = Sum(Cert_Delivarable.Amount WHERE("Conract No."=FIELD("Contract No."), Paid=FILTER(true)));
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
    }
    keys
    {
        key(Key1; "IPC No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
