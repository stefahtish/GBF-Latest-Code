table 50584 "Laboratory Test Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Lab; Code[50])
        {
            Caption = 'Lab';
            DataClassification = ToBeClassified;
        }
        field(2; Test; Code[100])
        {
            Caption = 'Test';
            DataClassification = ToBeClassified;
            TableRelation = "Test Setup";
        }
    }
    keys
    {
        key(PK; Lab, Test)
        {
            Clustered = true;
        }
    }
}
