table 50384 "Email Logging Liness"
{
    fields
    {
        field(1; No; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Sent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Error Message"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Payroll Shedules';
            OptionMembers = , "Payroll Shedules";
        }
        field(7; Period; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period";
        }
        field(8; "Client Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Institutions;
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
