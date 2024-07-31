table 50329 "Applicant Job Education2"
{
    Caption = 'Applicant Job Education';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            Caption = 'Applicant No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Education Type";Enum "Education Types")
        {
            Caption = 'Education Type';
            DataClassification = ToBeClassified;
        }
        field(3; Institution; Code[50])
        {
            Caption = 'Institution';
            DataClassification = ToBeClassified;
        }
        field(4; "Institution Name"; Text[250])
        {
            Caption = 'Institution Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(7; Country; Code[50])
        {
            Caption = 'Country';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(8; Region; Code[50])
        {
            Caption = 'Region';
        }
        field(9; "Field of Study"; Code[50])
        {
            Caption = 'Field of Study';
            DataClassification = ToBeClassified;
            TableRelation = "Field of Study";
        }
        field(10; "Qualification Code"; Code[50])
        {
            Caption = 'Qualification Code';
            DataClassification = ToBeClassified;
            //TableRelation = "Employee Qualifications".Code;
            TableRelation = "Employee Qualifications".Code where("Qualification Type"=const(Academic), "Field of Study"=field("Field of Study"), "Education Level"=field("Education Level33"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if EmployeeQualifications.get("Qualification Code")then "Qualification Name":=EmployeeQualifications.Description;
            end;
        }
        field(11; "Qualification Name"; Text[250])
        {
            Caption = 'Qualification Name';
            DataClassification = ToBeClassified;
        }
        field(12; "Education Level";enum "Education Level")
        {
            Caption = 'Education Level';
            DataClassification = ToBeClassified;
        }
        field(24; "Education Level33";enum "Education Level")
        {
            Caption = 'Education Level';
            DataClassification = ToBeClassified;
        }
        field(13; "Highest Level"; Boolean)
        {
            Caption = 'Highest Level';
            DataClassification = ToBeClassified;
        }
        field(14; Grade; Code[10])
        {
            Caption = 'Grade';
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(16; Score; Decimal)
        {
            Caption = 'Score';
            DataClassification = ToBeClassified;
        }
        field(17; "Proficiency Level";enum "Proficiency Level")
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Need Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Section/Level"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Qualification Code Prof"; Code[50])
        {
            Caption = 'Qualification Code';
            DataClassification = ToBeClassified;
            TableRelation = Qualification.Code;

            trigger OnValidate()
            begin
                if Qualifications.get("Qualification Code Prof")then "Qualification Name":=Qualifications.Description;
            end;
        }
        field(22; "Applicant Education level";enum "Applicant Education Level")
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Region Code"; Code[50])
        {
            Caption = 'Country';
            DataClassification = ToBeClassified;
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                CountyNew: Record CountyNew;
            begin
                CountyNew.Reset();
                CountyNew.SetRange("County Code", "Region Code");
                if CountyNew.FindFirst()then Region:=CountyNew.County;
            end;
        }
    }
    keys
    {
        key(PK; "Applicant No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var FieldOfStudy: Record "Field of Study";
    Qualifications: Record Qualification;
    "EmployeeQualifications": Record "Employee Qualifications";
}
