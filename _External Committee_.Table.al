table 50712 "External Committee"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Role; Option)
        {
            //DataClassification = ToBeClassified;
            OptionMembers = " ", Member, Chair, Secretary;
        }
        field(4; "Appointment No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "ID Number", "Appointment No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        TestField("ID Number");
    end;
}
