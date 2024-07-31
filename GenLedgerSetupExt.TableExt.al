tableextension 50163 GenLedgerSetupExt extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Collection Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Collection Bank"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Collection Bank Branch"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Posted Receipts No"; Code[20])
        {
            Caption = 'Posted Receipts No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50004; "Current Budget"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50005; "Current Budget Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Current Budget End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "PV Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50008; "Use Dimensions For Budget"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
