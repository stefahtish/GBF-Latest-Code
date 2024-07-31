table 50373 "Scale Benefits"
{
    DrillDownPageID = "Scale Benefits";
    LookupPageID = "Scale Benefits";

    fields
    {
        field(1; "Salary Scale"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(2; "Salary Pointer"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Pointer"."Salary Pointer" WHERE("Salary Scale"=FIELD("Salary Scale"));
        }
        field(3; "ED Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = EarningsX;

            trigger OnValidate()
            begin
                if EarningRec.Get("ED Code")then begin
                    "ED Description":=EarningRec.Description;
                    case EarningRec."Calculation Method" of EarningRec."Calculation Method"::"Flat amount": Amount:=EarningRec."Flat Amount";
                    end;
                end;
            end;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "ED Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Payment Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Amount,Hour Rate,Daily Rate,Percentage';
            OptionMembers = Amount, "Hour Rate", "Daily Rate", Percentage;
        }
        field(8; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Based on branches"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Salary Scale", "Salary Pointer", "ED Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var EarningRec: Record EarningsX;
}
