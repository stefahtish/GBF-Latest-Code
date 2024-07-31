table 50305 "Company Job Education"
{
    Caption = 'Company Job Education';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job ID"; Code[50])
        {
            Caption = 'Job ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(3; "Field of Study"; Code[50])
        {
            Caption = 'Field of Study';
            DataClassification = ToBeClassified;
            TableRelation = "Field of Study".Code;

            trigger OnValidate()
            begin
                if FieldOfStudy.get("Field of Study")then "Field Name":=FieldOfStudy.Description;
            end;
        }
        field(4; "Field Name"; Text[2000])
        {
            Caption = 'Field Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Education Level";enum "Education Level")
        {
            DataClassification = ToBeClassified;
        }
        field(6; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Qualification Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Qualification.Code where("Field of Study"=field("Field of Study"), "Education Level"=field("Education Level"));

            trigger OnValidate()
            begin
                if Qualifications.Get("Qualification Code")then "Qualification Name":=Qualifications.Description;
            end;
        }
        field(8; "Qualification Name"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Proficiency Level";enum "Proficiency Level")
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Section/Level"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Qualification Code Prof"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Qualification.Code;

            trigger OnValidate()
            begin
                if Qualifications.Get("Qualification Code Prof")then "Qualification Name":=Qualifications.Description;
            end;
        }
    }
    keys
    {
        key(PK; "Job ID", "Line No")
        {
            Clustered = true;
        }
    }
    var FieldOfStudy: Record "Field of Study";
    Qualifications: Record Qualification;
}
