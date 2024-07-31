table 50304 "Assignment Lines"
{
    Caption = 'Assignment Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; Assignment; Text[250])
        {
            Caption = 'Assignment';
            DataClassification = ToBeClassified;
        }
        field(3; "Date Asigned"; Date)
        {
            Caption = 'Date Asigned';
            DataClassification = ToBeClassified;
        }
        field(4; Assigner; Text[250])
        {
            Caption = 'Assigner';
            DataClassification = ToBeClassified;
        }
        field(5; "Implementation Status"; Option)
        {
            Caption = 'Implementation Status';
            DataClassification = ToBeClassified;
            OptionMembers = Completed, Pending;
        }
        field(6; "Date of Completion"; Date)
        {
            Caption = 'Date of Completion';
            DataClassification = ToBeClassified;
        }
        field(7; Remarks; Text[500])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(8; "Agreed Performance Target"; Text[250])
        {
            Caption = 'Agreed Performance Target';
            DataClassification = ToBeClassified;
        }
        field(9; "Perfomance Indicator"; Text[250])
        {
            Caption = 'Perfomance Indicator';
            DataClassification = ToBeClassified;
        }
        field(10; "Achieved Result"; Decimal)
        {
            Caption = 'Achieved Result';
            DataClassification = ToBeClassified;
        }
        field(11; Rating; Decimal)
        {
            Caption = 'Rating';
            DataClassification = ToBeClassified;
        }
        field(12; "Appraisal Performance Score"; Decimal)
        {
            Caption = 'Appraisal Performance Score';
            DataClassification = ToBeClassified;
        }
        field(13; "Moderated Score"; Decimal)
        {
            Caption = 'Moderated Score';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
