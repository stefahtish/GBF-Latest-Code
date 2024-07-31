table 50466 "Client Types"
{
    fields
    {
        field(1; "No."; Code[30])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; Company; Text[50])
        {
            TableRelation = Company;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var CRMSetup: Record "Interaction Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
