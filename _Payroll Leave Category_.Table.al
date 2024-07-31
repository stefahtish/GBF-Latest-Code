table 50190 "Payroll Leave Category"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            TableRelation = "Leave Type".Code;
        }
        field(2; "% of Basic Pay"; Integer)
        {
            Caption = '% of Basic Pay';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        TestField("% of Basic Pay");
    end;
}
