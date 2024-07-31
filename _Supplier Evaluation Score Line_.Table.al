table 50456 "Supplier Evaluation Score Line"
{
    Caption = 'Supplier Evaluation Score Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Supplier Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Score Parameter"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Score Description"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Maximum Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Score Type"; Option)
        {
            OptionMembers = " ", "Yes/No", "Criteria";
            OptionCaption = ' ,Yes/No,Criteria';
        }
        field(8; Score; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Score Criteria" = "Score Criteria"::Score then begin
                    if Score > "Maximum Score" then Error('%1 can not be greater than the Maximum set score of %2', Score, "Maximum Score");
                end;
            end;
        }
        field(9; "Y/N"; Option)
        {
            OptionMembers = " ", "No", "Yes";
        }
        field(10; "Score Criteria";enum "Supplier Evaluation Score Types")
        {
        }
        field(11; Passmark; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Pass/Fail"; Option)
        {
            OptionMembers = " ", "Pass", "Fail";
        }
        field(13; "Tender No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Criteria Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Supplier Code", "Score Parameter", "Line No.")
        {
            Clustered = true;
        }
    }
}
