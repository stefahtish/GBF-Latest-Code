table 50446 "Prospective Supplier Directors"
{
    Caption = 'Prospective Supplier Directors';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Prospect No."; Code[20])
        {
            Caption = 'Prospect No.';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Salutation; Text[200])
        {
            Caption = 'Salutation';
            DataClassification = ToBeClassified;
        }
        field(4; "ID No."; Code[10])
        {
            Caption = 'ID No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(6; "Postal Address"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Telephone Number"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Email address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Signature; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(10; Designation;enum Salutations)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Ethnicity; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Ethnic Communities";

            trigger OnValidate()
            var
                EthcGrp: Record "Ethnic Communities";
            begin
                "Ethnicity Description":='';
                if EthcGrp.Get(Ethnicity)then "Ethnicity Description":=EthcGrp."Ethnic Name";
            end;
        }
        field(12; "Ethnicity Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Prospect No.", "Line No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Line No":=GetNextLineNo();
    end;
    procedure GetNextLineNo(): Integer var
        Directors: Record "Prospective Supplier Directors";
    begin
        Directors.Reset();
        Directors.SetRange("Prospect No.", "Prospect No.");
        if Directors.FindLast()then exit(Directors."Line No" + 1000)
        else
            exit(1000);
    end;
}
