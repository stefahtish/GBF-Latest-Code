table 50372 "Salary Pointer"
{
    fields
    {
        field(1; "Salary Pointer"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Basic Pay int"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Salary Scale"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(5; "Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Salary Scale", "Salary Pointer")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
