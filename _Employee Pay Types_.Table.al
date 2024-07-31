table 50378 "Employee Pay Types"
{
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Earning Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = EarningsX;
        }
        field(4; Formula; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Calculation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Salary Scale,Formual';
            OptionMembers = "Salary Scale", Formual;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
