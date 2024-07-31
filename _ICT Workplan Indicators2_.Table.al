table 50203 "ICT Workplan Indicators2"
{
    Caption = 'ICT Workplan Indicators';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[500])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Perfomance Indicator Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance SubCriteria".Code; // where("Criteria Code" = field("Criteria Code"));

            trigger OnValidate()
            var
                Indicators: Record "Perfomance SubCriteria";
            begin
                Indicators.SetRange(Code, "Perfomance Indicator Code");
                if Indicators.FindFirst()then "Description":=Indicators.Description;
            end;
        }
    }
    keys
    {
        key(PK; "No.", "Perfomance Indicator Code")
        {
            Clustered = true;
        }
    }
}
