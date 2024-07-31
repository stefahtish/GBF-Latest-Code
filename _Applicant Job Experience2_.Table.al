table 50330 "Applicant Job Experience2"
{
    Caption = 'Applicant Job Experience';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            Caption = 'Job ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(3; Employer; Text[250])
        {
            Caption = 'Employer';
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if("Start Date" <> 0D) and ("End Date" <> 0D)then "No. of Years":=Round((("End Date" - "Start Date") / 365), 0.01, '=');
            end;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if("Start Date" <> 0D) and ("End Date" <> 0D)then "No. of Years":=Round((("End Date" - "Start Date") / 365), 0.01, '=');
                if "End Date" < "Start Date" then Error('End Date cannot be before the start date');
                "Experience Span":='';
                HumanResSetup.Get();
                HumanResSetup.TestField("Retirement Age");
                "Experience Span":=HRDates.DetermineAge("Start Date", "End Date");
            end;
        }
        field(6; "Present Employment"; Boolean)
        {
            Caption = 'Present Employment';
            DataClassification = ToBeClassified;
        }
        field(7; Industry; Code[50])
        {
            Caption = 'Industry';
            DataClassification = ToBeClassified;
            TableRelation = "Company Job Industry";
        }
        field(8; "Hierarchy Level";enum "Hierarchy Level")
        {
            DataClassification = ToBeClassified;
        }
        field(9; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Not Under Notice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Job Title"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Employer Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Mail.CheckValidEmailAddress("Employer Email Address");
            end;
        }
        field(13; "Employer Postal Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Functional Area"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Country; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(17; Location; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "No. of Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Need Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Total no of years in industry"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Most relevant industry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Current employment"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EndDate: Date;
            begin
                "Experience Span":='';
                "End Date":=0D;
                EndDate:=Today();
                HumanResSetup.Get();
                HumanResSetup.TestField("Retirement Age");
                "Experience Span":=HRDates.DetermineAge("Start Date", EndDate);
            end;
        }
        field(23; "Experience Span"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Applicant No.", "Line No")
        {
            Clustered = true;
        }
    }
    var Mail: Codeunit "Mail Management";
    HumanResSetup: Record "Human Resources Setup";
    HRDates: Codeunit "Dates Management";
}
