table 50495 "Audit Period"
{
    fields
    {
        field(1; Period; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Period Start"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Period End"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(6; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(7; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            ClosingDates = true;
            FieldClass = FlowFilter;
        }
        field(8; "Audit Filter"; Text[30])
        {
            FieldClass = FlowFilter;
            TableRelation = Audit;
        }
        field(9; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Audit,Workplan';
            OptionMembers = " ", Audit, Workplan;
        }
    }
    keys
    {
        key(Key1; Period, Type)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
