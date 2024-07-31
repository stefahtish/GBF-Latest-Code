table 50558 "Licensing dairy Enterprise"
{
    fields
    {
        //License application
        field(1; "Application no"; Code[50])
        {
        }
        field(2; "License Type"; Code[200])
        {
            TableRelation = "License and Permit Category"."License/Permit Category";
        }
        field(3; Year; BigInteger)
        {
        }
        field(4; Town; Text[30])
        {
        }
        field(5; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if PostCode.Get("Post Code")then Town:=PostCode.City;
            end;
        }
        field(6; "Office No."; Code[20])
        {
        }
        field(7; "E-Mail 1"; Code[80])
        {
        }
        field(8; "E-Mail 2"; Text[80])
        {
        }
        field(9; "Physical Address(Street/Road"; Text[30])
        {
        }
        field(10; Website; Text[150])
        {
        }
        field(11; "Registered Office"; Text[200])
        {
            NotBlank = false;
        }
        field(12; "Cell Phone Number 1"; Code[20])
        {
        }
        field(13; "County"; Text[30])
        {
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                cty: Record CountyNew;
            begin
                cty.SetRange("County Code", County);
                if cty.FindFirst()then "County Name":=cty.County;
            end;
        }
        field(14; SubCounty; Text[30])
        {
            TableRelation = "Sub-County"."Sub-County Code" where("County Code"=field(County));

            trigger OnValidate()
            var
                subc: Record "Sub-County";
            begin
                subc.SetRange("Sub-County Code", Subcounty);
                if subc.find('-')then begin
                    "Sub-County Name":=subc.Name;
                    Station:=subc.Station;
                end;
            end;
        }
        field(15; Location; Text[30])
        {
        }
        //Dairy enterprises
        field(16; "Business Name"; code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Date of incorporation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "End of Financial Year"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Country; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Station; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Physical Address(Building)"; Text[30])
        {
            Caption = 'Physical Address(Building/Market)';
        }
        field(22; "Cell Phone Number 2"; Code[20])
        {
        }
        //Applicant Details
        field(23; "First Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Middle Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Last Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "ID/Pasport"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Cell Phone Number"; Code[20])
        {
        }
        field(28; "E-Mail"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Username; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        //Dairy Manager
        field(30; "Dairy To be Managed"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Dairy Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Litres to be Managed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Office Number 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "License/Permit"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = License, Permit;
        }
        field(35; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LicenseApp: Record "Licensing dairy Enterprise";
            begin
                LicenseApp.Reset();
                ;
                LicenseApp.SetFilter("Application no", '<>%1', "Application no");
                LicenseApp.SetRange("ID Number", "ID Number");
                if LicenseApp.FindFirst()then Error('Applicant with same ID number already exists');
            end;
        }
        field(36; "Individual Pin Number"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LicenseApp: Record "Licensing dairy Enterprise";
            begin
                LicenseApp.Reset();
                LicenseApp.SetFilter("Application no", '<>%1', "Application no");
                LicenseApp.SetRange("Individual Pin Number", "Individual Pin Number");
                if LicenseApp.FindFirst()then Error('Applicant with same pin number already exists');
            end;
        }
        field(37; "Company Pin Number"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LicenseApp: Record "Licensing dairy Enterprise";
            begin
                LicenseApp.Reset();
                LicenseApp.SetFilter("Application no", '<>%1', "Application no");
                LicenseApp.SetRange("Company Pin Number", "Company Pin Number");
                if LicenseApp.FindFirst()then Error('Applicant with same company pin already exists');
            end;
        }
        field(38; "Company Registration Number"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LicenseApp: Record "Licensing dairy Enterprise";
            begin
                LicenseApp.Reset();
                LicenseApp.SetFilter("Application no", '<>%1', "Application no");
                LicenseApp.SetRange("Company Registration Number", "Company Registration Number");
                if LicenseApp.FindFirst()then Error('Applicant with same company registration number already exists');
            end;
        }
        field(39; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "", Individual, "Registered Entity";
            OptionCaption = ' ,Individual,Registered Entity';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                InsertDocuments("Application no");
            end;
        }
        field(41; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(42; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; Confirmed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "County Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Sub-County Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(46; Salutation;Enum Salutations)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Contact Person Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Contact Person Telephone"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Contact Person Salutation";Enum Salutations)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Postal Address"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Plot Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52; Market; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Approval Status";Enum "Approval Status-custom")
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Application no")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Application no")
        {
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        CompSetup.Get();
        CompSetup.TestField("App Dairy managers No.");
        NoSeriesMgt.InitSeries(CompSetup."App Dairy managers No.", xRec."No. Series", TODAY, "Application no", "No. Series");
    end;
    var PostCode: Record "Post Code";
    CompSetup: Record "Compliance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    procedure InsertDocuments(AppNo: Code[20])
    var
        ReqDocuments: Record "Compliance Documents";
        LicensingDocs: Record "Licensing Required Documents";
    begin
        LicensingDocs.SetRange("No.", AppNo);
        if LicensingDocs.Find('-')then LicensingDocs.DeleteAll();
        if AppNo <> ' ' then begin
            ReqDocuments.SetRange(Process, ReqDocuments.Process::Registration);
            ReqDocuments.SetRange("Registration Type", "Customer Type");
            if ReqDocuments.Find('-')then repeat LicensingDocs.Init();
                    LicensingDocs."No.":="Application no";
                    LicensingDocs.Document:=ReqDocuments.Document;
                    LicensingDocs.Insert(true);
                until ReqDocuments.Next() = 0;
        end;
    end;
}
