table 50342 "Perfomance Factor Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Appraisal No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Factor"; Text[1000])
        {
            Caption = 'Performance Indicator';
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Performance Factors";

            trigger OnValidate()
            var
                Perf: Record "Appraisal Performance Factors";
            begin
                if Perf.get(Factor)then Description:=Perf.Description;
            end;
        }
        field(4; "Description"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Remarks"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Performance Rating"; Option)
        {
            Optionmembers = "N/A", "1", "2", "3", "4", "5";
            optionCaption = 'N/A,1,2,3,4,5';
        }
        field(7; "Agreed Performance Target"; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Revised Target"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Revised Indicator"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Rating Of % level"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Performance Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Moderated Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Appraisal No", "Line No.")
        {
            Clustered = true;
        }
    }
}
