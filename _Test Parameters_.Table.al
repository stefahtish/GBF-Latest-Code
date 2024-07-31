table 50249 "Test Parameters"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Max Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Pass Mark"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Pass Mark" > "Max Marks" then Error('Pass mark cannot be higher than maximum marks');
            end;
        }
    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
