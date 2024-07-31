table 50583 "Test Setup"
{
    Caption = 'Test Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Test; Code[100])
        {
            Caption = 'Test';
            DataClassification = ToBeClassified;
        }
        field(2; "Test Form";Enum LabTestForms)
        {
            Caption = 'Test Form';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Test)
        {
            Clustered = true;
        }
    }
}
