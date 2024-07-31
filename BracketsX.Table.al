table 50359 BracketsX
{
    fields
    {
        field(1; "Tax Band"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Table Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bracket TablesX";
        }
        field(4; "Lower Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Upper Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Pay period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Taxable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Total taxable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Factor Without Housing"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2: ;
        }
        field(14; "Factor With Housing"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2: ;
        }
        field(15; Institution; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Contribution Rates Inclusive"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Tax Band", "Table Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
