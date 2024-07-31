table 50596 "Enforcement Nature of Produce2"
{
    Caption = 'Enforcement Nature of Produce ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Nature of Produce"; Code[50])
        {
            Caption = 'Nature of Produce';
            DataClassification = ToBeClassified;
            TableRelation = "Dairy Produce Setup";
        }
        field(3; "Description"; Text[100])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(4; Others; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Specify; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Nature of Produce")
        {
            Clustered = true;
        }
    }
}
