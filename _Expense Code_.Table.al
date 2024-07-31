table 50555 "Expense Code"
{
    DrillDownPageID = "Expense Code";
    LookupPageID = "Expense Code";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
        }
        field(3; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(5; Type; Option)
        {
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ", "G/L Account", Item, , "Fixed Asset", "Charge (Item)";
        }
        field(6; "Expense Type"; Option)
        {
            OptionCaption = 'Training,Admin,Investment,Property';
            OptionMembers = Training, Admin, Investment, Property;
        }
        field(7; "Per Diem"; Boolean)
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
    }
    fieldgroups
    {
    }
}
