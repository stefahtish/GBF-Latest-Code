table 50639 "Research Budget Setup"
{
    Caption = 'Research Budget Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Activity Code"; Code[20])
        {
            Caption = 'Activity Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".code where("Global Dimension No."=const(3));

            trigger OnValidate()
            var
                DimValues: Record "Dimension Value";
            begin
                DimValues.Reset();
                DimValues.SetRange(Code, "ACtivity Code");
                DimValues.SetRange("Global Dimension No.", 3);
                if DimValues.FindFirst()then "Name":=DimValues.Name;
            end;
        }
        field(2; "Research and Survey"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Promotion Activities"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Stakeholder support"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Dairy Standards"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Partnersip Activities"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Activity Code")
        {
            Clustered = true;
        }
    }
}
