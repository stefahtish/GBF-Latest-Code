table 50564 "Lab Annual Schedule Line"
{
    fields
    {
        field(1; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST(Laboratory))"Laboratory Setup Type" where(Type=const(Laboratory));

            // ELSE
            // IF (Type = CONST(Reagents)) "Laboratory setups" where(Type = const(Reagents))
            // ELSE
            // IF (Type = CONST(Consumbles)) "Laboratory setups" where(Type = const(Consumbles));
            trigger OnValidate()
            var
                Labsetups: Record "Laboratory Setup Type";
            begin
                if Labsetups.Get(Name)then Description:=Labsetups.Description;
            end;
        }
        field(3; Description; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type;Enum LabSetupTypes)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", Name)
        {
            clustered = true;
        }
    }
}
