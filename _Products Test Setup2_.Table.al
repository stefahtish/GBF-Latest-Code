table 50620 "Products Test Setup2"
{
    Caption = 'Products Test Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Product; Code[50])
        {
            Caption = 'Product';
            DataClassification = ToBeClassified;
        }
        field(2; Test; Code[100])
        {
            Caption = 'Test';
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Test Setup".Test;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
            end;
        }
        field(3; "Lab Section"; Text[1000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Lab section to test"));
        }
        field(4; "Lab"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Laboratory Test Setup".Lab where(Test=field(Test)));
        }
    }
    keys
    {
        key(PK; Product, "Lab Section", Test)
        {
            Clustered = true;
        }
    }
}
