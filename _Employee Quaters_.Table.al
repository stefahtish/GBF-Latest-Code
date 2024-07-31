table 50263 "Employee Quaters"
{
    fields
    {
        field(1; "Asset No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No." WHERE("FA Subclass Code"=FILTER('BUILDING'));

            trigger OnValidate()
            begin
                FA.Reset;
                FA.SetRange("No.", "Asset No");
                if FA.Find('-')then begin
                    Description:=FA.Description;
                    Location:=FA."FA Location Code";
                end;
            end;
        }
        field(2; Description; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Location; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Cost Per Occupant"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(5; "Rent Chrage"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Cost Per Occupant":=("Rent Chrage" + "Water Charge" + "Electricity Charge" + "Security Charge");
            end;
        }
        field(6; "Security Charge"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Cost Per Occupant":=("Rent Chrage" + "Water Charge" + "Electricity Charge" + "Security Charge");
            end;
        }
        field(7; "Water Charge"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Cost Per Occupant":=("Rent Chrage" + "Water Charge" + "Electricity Charge" + "Security Charge");
            end;
        }
        field(8; "Electricity Charge"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Cost Per Occupant":=("Rent Chrage" + "Water Charge" + "Electricity Charge" + "Security Charge");
            end;
        }
        field(9; "No of Units"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Total Occupied"; Integer)
        {
            CalcFormula = Count("House Units" WHERE("Quaters Code"=FIELD("Asset No"), Status=CONST(Occupied)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Total Vacant"; Integer)
        {
            CalcFormula = Count("House Units" WHERE("Quaters Code"=FIELD("Asset No"), Status=CONST(Vacant)));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Asset No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var FA: Record "Fixed Asset";
}
