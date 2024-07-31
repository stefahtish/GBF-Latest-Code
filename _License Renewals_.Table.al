table 50606 "License Renewals"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Applicant No."; Code[20])
        {
            Caption = 'Applicant No.';
            DataClassification = ToBeClassified;
            Tablerelation = "Licensing dairy Enterprise";

            trigger OnValidate()
            var
                App: record "Licensing dairy Enterprise";
            begin
                App.SetRange("Application no", "Applicant No.");
                if App.FindFirst()then begin
                    if app."Customer Type" = App."Customer Type"::Individual then Name:=App."First Name" + ' ' + App."Middle Name" + ' ' + App."Last Name"
                    else
                        Name:=app."Business Name";
                    Email:=app."E-Mail 1";
                    "Customer No.":=App."Customer No.";
                end;
            end;
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = License, Permit;
            DataClassification = ToBeClassified;
        }
        field(4; Category; Text[100])
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
            TableRelation = "License and Permit Category"."License/Permit Category";
        }
        field(5; "License No."; Text[80])
        {
            Caption = 'Permit No.';
            DataClassification = ToBeClassified;
            TableRelation = "Issued Applicant License"."License No." where("Applicant No."=field("Applicant No."));

            trigger OnValidate()
            var
                Licenses: Record "Issued Applicant License";
            begin
                Licenses.Reset();
                Licenses.SetRange("Applicant No.", "Applicant No.");
                Licenses.SetRange("License No.", "License No.");
                if Licenses.FindFirst()then begin
                    Outlet:=Licenses.Outlet;
                    Category:=Licenses.Category;
                end;
            end;
        }
        field(6; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open, "Pending inspection", "Pending permit fee payment", Approved, Rejected;
            DataClassification = ToBeClassified;
        }
        field(10; Paid; Boolean)
        {
            Caption = 'Paid';
            DataClassification = ToBeClassified;
        }
        field(11; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(12; Email; Text[100])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
        field(13; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Outlet; Code[50])
        {
            Caption = 'Name of Premise';
            DataClassification = ToBeClassified;
            TableRelation = "License Applicants Branches".Outlet where("Application no"=field("Applicant No."));
        }
        field(17; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Issued Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "License fee Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "License fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "License fee Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Paid license fee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Reason for non-issuance"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        CompSetup.Get();
        CompSetup.TestField("License Renewal No.");
        NoSeriesMgt.InitSeries(CompSetup."License Renewal No.", xRec."No. Series", TODAY, "No.", "No. Series");
        "Application Date":=today;
    end;
    var PostCode: Record "Post Code";
    CompSetup: Record "Compliance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
