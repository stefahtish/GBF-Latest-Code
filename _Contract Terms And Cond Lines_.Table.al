table 50699 "Contract Terms And Cond Lines"
{
    Caption = 'Contract Terms And Cond Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Contract No."; Code[50])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Terms Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Contract Terms And Conditions";

            trigger OnValidate()
            var
                ContractTerms: Record "Contract Terms and Conditions";
            begin
                ContractTerms.Reset();
                If ContractTerms.Get("Terms Code")then "Terms Text":=ContractTerms."Terms & Condition Description";
            end;
        }
        field(4; "Terms Text"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Contract No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
