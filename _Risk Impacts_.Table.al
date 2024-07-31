table 50503 "Risk Impacts"
{
    DrillDownPageID = "Risk Impacts";
    LookupPageID = "Risk Impacts";

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Impact Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Financial start"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Financial End"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Impact Score")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Impact Score", "Financial start", "Financial End")
        {
        }
    }
}
