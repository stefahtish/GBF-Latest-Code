table 50739 "Tax Tarriff Code"
{
    DrillDownPageID = "Tax Tarriff Codes";
    LookupPageID = "Tax Tarriff Codes";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Percentage; Decimal)
        {
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account"
            ELSE IF("Account Type"=CONST(Vendor))Vendor."No.";
        }
        field(5; Type; Option)
        {
            OptionCaption = ' ,W/Tax,VAT,Excise,W/VTax,Retention,Income Tax';
            OptionMembers = " ", "W/Tax", VAT, Excise, "W/VTax", Retention, "Income Tax";
        }
        field(12; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset", "IC Partner";
        }
        field(13; Blocked; Boolean)
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
