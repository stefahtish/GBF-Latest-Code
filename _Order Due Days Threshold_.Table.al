table 50181 "Order Due Days Threshold"
{
    Caption = 'Due days threshold';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Band name"; Code[50])
        {
            Caption = 'Band name';
            DataClassification = ToBeClassified;
        }
        field(2; "Lower Limit"; Decimal)
        {
            Caption = 'Lower Limit';
            DataClassification = ToBeClassified;
        }
        field(3; "Upper Limit"; Decimal)
        {
            Caption = 'Upper Limit';
            DataClassification = ToBeClassified;
        }
        field(4; "Due days"; DateFormula)
        {
            Caption = 'Due days';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Band name")
        {
            Clustered = true;
        }
    }
}
