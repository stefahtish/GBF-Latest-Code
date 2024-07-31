table 50717 "Performance Indicator"
{
    Caption = 'Performance Indicator';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Initiatives; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; ObjectiveCode; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Imp Objectives".Code;

            trigger OnValidate()
            var
                StratObj: Record "Strategic Imp Objectives";
            begin
                if StratObj.Get(ObjectiveCode)then "Strategic Objectives":=StratObj.Description;
            end;
        }
        field(4; "Strategic Objectives"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; ObjectiveCode, Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Initiatives)
        {
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Validate(ObjectiveCode);
    end;
}
