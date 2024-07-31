table 50601 "License Applications"
{
    Caption = 'License Applications';
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
                    if "Customer No." <> '' then begin
                        "Customer No.":=App."Customer No.";
                    end
                    else
                    begin
                        "Customer No.":='';
                    end;
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
            DataClassification = ToBeClassified;
            TableRelation = "License and Permit Category"."License/Permit Category";

            trigger OnValidate()
            var
                ReqDocuments: Record "Compliance Documents";
                LicensingDocs: Record "Licensing Required Documents";
            begin
                LicensingDocs.reset;
                LicensingDocs.SetRange("No.", "No.");
                if LicensingDocs.Find('-')then LicensingDocs.DeleteAll();
                if "No." <> ' ' then begin
                    ReqDocuments.reset();
                    ReqDocuments.SetRange(Process, ReqDocuments.Process::"Regulatory Permit Application");
                    ReqDocuments.SetRange("License Category", Category);
                    if ReqDocuments.Find('-')then repeat LicensingDocs.Init();
                            LicensingDocs."No.":="No.";
                            LicensingDocs.Document:=ReqDocuments.Document;
                            LicensingDocs.Insert();
                        until ReqDocuments.Next() = 0;
                end;
            end;
        }
        field(5; "License No."; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            OptionMembers = Open, "Pending inspection", "Station Manager", "Head Office", HOD, "Pending permit fee payment", Approved, Rejected, Archived;
            DataClassification = ToBeClassified;
        }
        field(10; Paid; Boolean)
        {
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
        field(18; "License fee Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "License fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "License fee Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Issued Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Expiry Date"; Date)
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
        field(25; Station; Code[50])
        {
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            CalcFormula = lookup("Licensing dairy Enterprise".Station where("Application no"=field("Applicant No.")));
        }
        field(26; "Renewal License No."; Text[80])
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
        field(27; "Application Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Application, Renewal;
        }
        field(28; "Approval Status";Enum "Approval Status-custom")
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Sent to LIS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Inspection findings"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Station Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if Emp.Get("Station Manager")then "Station Manager Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(32; "Station Manager Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Head Office"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(34; "QR Code"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "QR Text"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Station Manager comment"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Head office comment"; Text[1000])
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
        CompSetup.TestField("License/Permit App No.");
        NoSeriesMgt.InitSeries(CompSetup."License/Permit App No.", xRec."No. Series", TODAY, "No.", "No. Series");
        "Application Date":=Today;
    end;
    var PostCode: Record "Post Code";
    CompSetup: Record "Compliance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
