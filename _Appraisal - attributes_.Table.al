table 50324 "Appraisal - attributes"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; AttributeCode; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Work related attributes";

            trigger OnValidate()
            var
                Attributes: Record "Work related attributes";
            begin
                if Attributes.Get(AttributeCode)then Attribute:=Attributes.Description;
            end;
        }
        field(2; Attribute; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Indicator code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Work related indicators".Code where(AttributeCode=field(AttributeCode));

            trigger OnValidate()
            var
                Indicators: Record "Work related indicators";
            begin
                Indicators.SetRange(Code, "Indicator code");
                if Indicators.FindFirst()then Indicator:=Indicators.Description;
            end;
        }
        field(4; Indicator; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Appraisal No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Rating; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Remarks; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Expected rating attributes"; Decimal)
        {
            Caption = 'Expected rating';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Appraisal No.", AttributeCode, "Indicator code", "Line No")
        {
            Clustered = true;
        }
    }
}
